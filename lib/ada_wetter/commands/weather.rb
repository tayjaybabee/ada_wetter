require 'rest-client'

module AdaWetter::Application::Weather

  require 'ada_wetter/commands/weather/forecast'

  class APIError < AdaWetter::Application::Error
    attr_accessor :message, :hint

    def message
      'There seems to be an API Error'
    end

    def hint
      'Please check your documentation'
    end

    class IncorrectKeyError < APIError
      attr_accessor :message, :hint

      def message
        'Your API key seems to be incorrect'
      end

      def hint
        'Please visit the DarkSky API website: https://darksky.net/dev/login'
      end
    end

  end

  def self.check_key(key)
    require 'json'
    begin

      url = "https://api.darksky.net/forecast/#{key}/37.8267,-122.4233"
      api = RestClient.get(url) { |response, request, result| response }

      JSON.parse(api)
    end
  end
end
