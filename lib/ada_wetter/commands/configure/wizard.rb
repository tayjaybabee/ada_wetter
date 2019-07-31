module AdaWetter
  module Configure
    class  Wizard
      require 'tty-prompt'
      require 'ada_wetter/commands/configure/common/database'

      @weather_api_reg = "https://darksky.net/dev/register"

      def ask_name

        @prompt.ask('What is your name?')

      end

      def check_locale(l)
        if Geocoder.search(l)
          true
        else
          false
        end
      end

      def confirm_locale(results)
        results.to_a
        loc_arr = []
        results.each do |r|
          loc_arr.push r.data['display_name']
        end
        @prompt.enum_select('Correct locale?', loc_arr, per_page: 4, cycle: true, default: 1)


      end


      def ask_locale
        require 'geocoder'

        gc = @prompt.ask('What is your location? (Address or zipcode)') do |l|
          l.required true
        end

      end


      def ask_api_key
        require 'ada_wetter/commands/weather'

        begin
          api_key = @prompt.ask'What is your DarkSky API Key?'
          if !AdaWetter::Weather.check_key(api_key)
            raise IncorrectKeyError
          end
        end
      end




      def initialize
        require 'ada_wetter/commands/configure/common/database'
        require 'geocoder'
        @prompt = TTY::Prompt.new

        name = ask_name
        locale = ask_locale
        unless check_locale(locale)
          ask_locale
        end
        locale = Geocoder.search(locale)
        p locale.to_s
        confirm_locale(locale)
        api_key = ask_api_key

        if !AdaWetter::Configure::Database.readout
          create = @prompt.yes?('No configuration file found, would you like me to make a new one?')
          if create
            @config = AdaWetter::Configure::Database.create
          else
            say 'Exiting.'
          end
        end
      end
    end
  end
end



