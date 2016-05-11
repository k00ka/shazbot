# Slack web client demo file
require 'slack'

Slack.config.token = ENV['SLACK_BOT_TOKEN']

client = Slack::Web::Client.new
client.auth_test

puts client.channels_list.channels

#client.files_upload(
#  channels: '#general',
#  as_user: true,
#  file: Faraday::UploadIO.new('/Users/David/Downloads/slider options.png', 'image/png'),
#  title: 'Slider options image',
#  filename: 'slider options.png',
#  initial_comment: 'New designs.'
#)

puts client.users_info(user: '@jason')
