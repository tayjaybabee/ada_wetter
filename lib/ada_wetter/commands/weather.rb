module AdaWetter::Weather

  require 'ada_wetter/commands/weather/forecast'

  class IncorrectKeyError < StandardError
    msg = "That key doesn't appear to be correct."
  end

  def self.check_key(conf)
    require 'open-uri'
    require 'json'

    url = 'https://api.darksky.net/forecast/d992c816780660fc355472315d211d6/37.8267,-122.4233'

    begin
      open(url)
    end

  end

end
