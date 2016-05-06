require './lib/shazbot'
require './lib/behaviour'

bot = Shazbot.new(ENV[Shazbot.token_env_var], Behaviour.config)
bot.start!
