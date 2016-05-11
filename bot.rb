# Shazbot runner - Ruby Hack Night chatbot
# Original code by David Andrews and Jason Schweier, 2016 - Ryatta.com
#
require './lib/shazbot'
require './lib/behaviour'

bot = Shazbot.new(ENV['SHAZBOT_SLACK_TOKEN'], Behaviour.config)
bot.start!
