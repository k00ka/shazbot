# Shazbot runner - Ruby Hack Night chatbot
# Original code by David Andrews and Jason Schweier, 2016 - Ryatta.com
#
require './lib/mybot'
bot = MyBot.new(ENV['SHAZBOT_SLACK_TOKEN'])
bot.start!
