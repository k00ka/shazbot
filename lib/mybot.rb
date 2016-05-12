# Shazbot customizer class - Ruby Hack Night chatbot
# Original code by David Andrews and Jason Schweier, 2016 - Ryatta.com
#
require './lib/shazbot.rb'

require 'slack'
require 'open-uri'
require 'wolfram'

require 'byebug'
require "pry"

class MyBot < Shazbot
  def initialize(auth_token)
    super

    # Why should we do this?
    # Why shouldn't we do this?
    @weather_token = '83658a490b36698e09e779d265859910'
    @giphy_token = 'dc6zaTOxFJmzC'
    Wolfram.appid = ENV['WOLFRAM_APPID']

    # define some state/variables for our bot here
    # e.g we can cache our wolfram queries to save some API calls and respond faster
    @wolfram_queries = {}
  end

  said "stackhappy" do |data|
    stack_happy(data)
  end

  said "stackme" do |data|
    stack_me(data)
  end

  said /\b(hi|hello|howdy|yo)\b/ do |data|
    message channel: data.channel, text: "Hi <@#{data.user}>! :wave:"
  end

  said "time" do |data|
    response = [ "It is now #{Time.now.strftime("%l:%M %P").strip}", "The time is currently #{Time.now.strftime("%l:%M %P").strip}", "I've got #{Time.now.strftime("%l:%M %P").strip}" ].sample
    message channel: data.channel, text: response
  end

  condition ->(msg){ msg =~ /\b(weather|temperature)\b/ } do |data|
    say_current_temp(data)
  end

  said /\bgif\b/ do |data|
    serve_a_gif(data)
  end

  condition ->{ Wolfram.appid } do |data|
    wolfram_alpha_search(data)
  end

  # alternative fallback if Wolfram is not enabled, above
  condition ->{ true } do |data|
    message channel: data.channel, text: "Sorry <@#{data.user}>, what:question:"
  end

private
  def stack_happy(data)
    uri = uri_for(data.text.gsub("stackhappy", "").strip)
    begin
      search_result = JSON.parse(uri.read)
      links = search_result["items"].map { |ans| ans["link"] }.take(1)
      response = links.any? ? links.join("\n") : sassy_nil_response
    rescue => e
      puts e.message
      response = ":funeral_urn: Your query has died. Funeral services are tomorrow at 7am"
    end

    message channel: data.channel, text: response, unfurl_links: true
  end

  def stack_me(data)
    uri = uri_for(data.text.gsub("stackme", "").strip)
    begin
      result = JSON.parse(uri.read)
      attachments = result["items"].map { |ans| { text: ans["link"], title: ans["title"] }}.take(5)
      if attachments.any?
        web_client.chat_postMessage channel: data.channel, attachments: attachments, unfurl_links: true
      else
        message channel: data.channel, text: sassy_nil_response
      end
    rescue => e
      puts e.message
      response = ":funeral_urn: Your query has died. Funeral services are tomorrow at 7am"
      message channel: data.channel, text: response, unfurl_links: true
    end
  end

  def uri_for(query)
    URI.parse("https://api.stackexchange.com/2.2/search/advanced?order=desc&sort=relevance&q=#{URI.escape(query)}&site=stackoverflow")
  end

  def sassy_nil_response
    [
      ["No results!", "Nada.", "Zilch."].sample,
      ["Aren't you the unique :snowflake:", "Here's your consolation prize :poop:"].sample
    ].join(" ")
  end

  def say_current_temp(data)
    uri = URI.parse("http://api.openweathermap.org/data/2.5/weather?APPID=#{@weather_token}&q=#{URI.escape(data.text)}")
    begin
      weather = JSON.parse(uri.read)
      location = weather["name"]
      temp = (weather["main"]["temp"]-273.15).round(1) # temp is in Kelvin! LOL
      response = "It is currently #{temp}C in #{location}"
    rescue
      response = "Oops, my weather feed is down. Check CP24. :stuck_out_tongue_winking_eye:"
    end
    message channel: data.channel, text: response
  end

  def serve_a_gif(data)
    query = data.text.sub(/gif/,"").strip
    uri = URI.parse("http://api.giphy.com/v1/gifs/random?api_key=#{@giphy_token}&tag=#{URI.escape(query)}")
    begin
      response = JSON.parse(uri.read)["data"]
      if response.empty?
        response = "I didn't find anything. https://media.giphy.com/media/PgbXsiT0EVuta/200_d.gif"
      else
        response = response["fixed_height_downsampled_url"]
        response = "LOL. I can't stop laughing at this one. #{response}" if rand < 0.1 # add with 1/10 frequency
      end
    rescue Exception => e
      response = "Oops. https://media.giphy.com/media/AmT7Raa4GJQsM/200_d.gif"
    end
    message channel: data.channel, text: response
  end

  def wolfram_alpha_search(data)
    begin
      typing channel: data.channel

      query  = data.text.strip
      result = fetch_wolfram_query_for(query)
      hash   = Wolfram::HashPresenter.new(result).to_hash

      image_urls = result.pods.map { |p| p.img["src"] }

      data_attachments =
        hash[:pods]
          .except("Images", "Image")
          .reject { |_, text| text.empty? || text.first.empty? }
          .map do |title, texts|
            {
              title: title,
              text: texts.join("\n")
            }
          end

      attachments = [{
        image_url: image_urls.drop(1).first, # drop the image title
        title: query,
        text: "I found you this:",
      }].concat(data_attachments)

      web_client.chat_postMessage channel: data.channel, attachments: attachments
    rescue
      message channel: data.channel, text: "Sorry, I could not complete your query"
    end
  end

  def fetch_wolfram_query_for(query)
    if @wolfram_queries.key?(query)
      @wolfram_queries[query]
    else
      result = Wolfram.fetch(query)
      @wolfram_queries[query] = result
      result
    end
  end
end
