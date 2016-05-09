require './lib/shazbot'
require './lib/behaviour'

bot = Shazbot.new(ENV['SHAZBOT_SLACK_TOKEN'], Behaviour.config)
bot.start!
