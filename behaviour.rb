module Behaviour
  def self.config
    @@config
  end

  # This table specifies matchers and handlers. The first matching row will be run.
  @@config = 
  [
    [ "hi", :say_hi ],
    [ /time/, :say_time ],
    [ ->(text){ true }, :say_wat? ]
  ]

  module Handlers
    def say_hi(data)
      message channel: data.channel, text: "Hi <@#{data.user}>!"
    end

    def say_wat?(data)
      message channel: data.channel, text: "Sorry <@#{data.user}>, what?"
    end

    def say_time(data)
      message channel: data.channel, text: "It is now #{Time.now.strftime("%l:%M %P").strip}"
    end
  end
end
