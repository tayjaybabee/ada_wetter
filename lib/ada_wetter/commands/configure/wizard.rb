module AdaWetter
  module Configure
    class  Wizard
      require 'tty-prompt'

      @weather_api_reg = "https://darksky.net/dev/register"

      def intro(name)
        HighLine.default_instance.wrap_at = 80
        HighLine.default_instance.page_at = 22

        say(<<~INTRODUCTION)
                   
          !!IMPORTANT!!- Note on API & Keys -!!IMPORTANT!!
          
          AdaWetter will not be able to display the local weather without an API key from DarkSky/Forecast.io (You'll need to 
          register as a dev)
            
          DarkSky API Registration URL: https://darksky.net/dev/register
        INTRODUCTION



        menu = @prompt.select("How would you like to proceed, #{name}?") do |m|

          m.choice name: 'Provide DarkSky API key', value: 1
          m.choice name: 'Go to registration link in default browser', value: 2
          m.choice name: 'Copy registration link to clipboard', value: 3
          m.choice name: 'Skip (You will not be able to lookup weather data!)', value: 4, disabled: '(DISABLED - NO METHOD)'
          m.choice name: 'Quit', value: 5

        end

        db = AdaWetter::Configure::Database

        AdaWetter::Configure::Database.readout

        case menu

        when 1
          api_key = prompt.ask("What is your DarkSky API key?")


        when 2
          require 'launchy'
          Launchy.open("https://darksky.net/dev/register")

        when 3
          require 'clipboard'
          Clipboard.implementation = Clipboard::Gtk
          Clipboard.copy("https://darksky.net/dev/register")

        end
        
      end

      def ask_name

        @prompt.ask("What is your name?") do |q|
          q.required true
          q.validate /\A\w+\Z/
          q.modify   :capitalize

        end


      end


      def initialize
        require 'ada_wetter/commands/configure/common/database'
        @prompt = TTY::Prompt.new
        if !AdaWetter::Configure::Database.readout
          create = @prompt.yes?'No configuration file found, would you like me to make a new one?'
          if create
            @config = AdaWetter::Configure::Database.create
            @config.read
          else
            say 'Exiting.'
          end
        else
          require 'tty-config'
          conf = AdaWetter::Configure::Database.readout
          @config = TTY::Config.new
          @config.filename='settings'
          @config.extname='.yml'
          if File.exist?('../conf/settings.yml')
            p @config.read('../conf/settings.yml')
            p @config.fetch(:mindsync, :enabled?)
            p @config.set('mindsync.enabled?', value: true)
            begin
              p @config.write('../conf/settings.yml')
            rescue TTY::Config::WriteError => e
              ask_overwrite = @prompt.yes?('This configuration file already exists! Overwrite?(y/n)')
              if ask_overwrite

                p @config.write('../conf/settings.yml', force: true)
              else

                @prompt.keypress('Press carriage return to exit', keys: [:return])
                exit()
              end
            end
            p @config
          else
            p 'nope'
          end
        end


        name = ask_name

        if defined?(name)
          p "Hello #{name}"
          intro(name)
        else
          say 'See ya stranger'
        end

      end

    end
  end
end