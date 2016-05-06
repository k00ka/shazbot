require 'slack'
require './lib/behaviour'

class Shazbot < Slack::RealTime::Client
  include Behaviour::Handlers

  def initialize(auth_token, behaviours)
    set_auth_token(auth_token) # set the token before initializing the client!
    super()
    @behaviours = behaviours
    register_callbacks
  end

  def self.token_env_var
    "SHAZBOT_SLACK_TOKEN"
  end

private
  def set_auth_token(token)
    unless token
      $stderr.puts "No token set! Bailing!"
      raise ArgumentError, "Token not set. Perhaps you forgot to set #{self.class.token_env_var} in your environment?"
    end
    Slack.config.token = token
  end

  def register_callbacks
    on :hello do
      $stderr.puts "Successfully connected, welcome '#{self.self.name}' to the '#{team.name}' team at https://#{team.domain}.slack.com."
    end

    on :message do |data|
      # DO NOT REMOVE: ignore any messages that are either from a bot or on a general channel (i.e. DMs only)
      next if users[data.user].is_bot || data.channel.start_with?('C')

      matcher, handler = @behaviours.detect { |matcher, _| matcher.respond_to?(:call) ? matcher.call(data.text) : data.text.match(matcher) }
      method(handler).call(data) if handler
    end

    on :close do |_data|
      $stderr.puts "client is about to disconnect"
    end

    on :closed do |_data|
      $stderr.puts "client has disconnected successfully!"
    end
  end
end
