module AdaWetter
  class Application
    module Configure
      class Wizard
        require 'tty-prompt'
        require 'ada_wetter'
        require 'ada_wetter/commands/configure/common/database'

        @weather_api_reg = "https://darksky.net/dev/register"

        def ask_name

          @prompt.ask('What is your name?') do |q|
            q.required true
            q.modify   :capitalize
            q.messages[:required?]= 'Your name is required!'
          end

        end

        def check_locale(name, l)
          results = Geocoder.search(l)
          confirm_locale(name, results)
        end


        def confirm_locale(name, results)
          require 'ada_wetter/helpers/network'
          begin
            results.to_a
            loc_arr = []
            results.each do |r|
              loc_arr.push r.data['display_name']
            end
            0
            if loc_arr.empty?
              @prompt.warn 'No information found for given location' if @verbose
              @prompt.say 'Checking network connection...' if @verbose
              if @network.connected?
                @prompt.ok 'Network connected!' if @verbose
                @prompt.say 'Asking user to try again...' if @verbose
                raise AdaWetter::Application::Configure::ConfigError::GeocodeError
              else
                raise AdaWetter::Application::Network::Error::NoConnectionError
              end
            else
              opts = %w(quit retry help)
              loc_arr << opts
              @prompt.enum_select('Correct locale?', loc_arr, per_page: 4, cycle: true, default: 1)
            end
          rescue AdaWetter::Application::Configure::ConfigError::GeocodeError => e
            @prompt.warn e.message
            @prompt.say e.hint if @verbose
            ask_locale(name)
          rescue @network::Error::NoConnectionError => e
            @prompt.error e.message
            @prompt.say e.hint if @verbose
            exit
          end


        end

        def ask_locale(name)
          require 'geocoder'

          gc = @prompt.ask("#{name}, where do you live (Address or zipcode)") do |l|
            l.required true
          end
          check_locale(name, gc)
        end

        def ask_api_key
          require 'ada_wetter/commands/weather'

          begin
            api_key = @prompt.ask 'What is your DarkSky API Key?' do |q|
              q.required(true)
              q.messages[:required?] = 'API key must not be empty.'
            end

            response = AdaWetter::Application::Weather.check_key(api_key)
            if response.has_key? 'code'
              if response['code'] == 403
                raise AdaWetter::Application::Weather::APIError::IncorrectKeyError
              else
                raise AdaWetter::Application::Weather::APIError
              end
            end
          rescue AdaWetter::Application::Weather::APIError::IncorrectKeyError => e

            puts e.message + "\n" + 'Please check your key and try again'
            ask_api_key

          rescue AdaWetter::Application::Weather::APIError => e
            p e.message

          end
        end

        def wizard(conf)
          begin
            name   = ask_name
            locale = ask_locale(name)
            api_key = ask_api_key
          end
        end

        def checklist
          begin
            @prompt.say 'Checking network...' if @verbose
            raise NoConnectionError unless @network.connected?

            say 'Checking for config file...' if @verbose
            conf = AdaWetter::Application.settings
            @prompt.say "Config file contents: #{conf.to_h}"
          rescue AdaWetter::Application::Network::Error::NoConnectionError => e
            say e.message
            say e.hint
            exit
          end
          conf
        end

        def initialize(opts)
          require 'ada_wetter/commands/configure/common/database'
          require 'geocoder'
          require 'ada_wetter/helpers/network'
          @prompt = TTY::Prompt.new

          if opts.verbose
            @verbose = true
            @prompt.ok '--verbose option received'
          else
            @verbose = false
          end

          @network = AdaWetter::Application::Network

          conf = checklist
          @prompt.ok 'Checklist OK!'

          wizard(conf)

        end
      end
    end
  end
end




