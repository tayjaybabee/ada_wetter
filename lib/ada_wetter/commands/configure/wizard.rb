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

        case menu

        when 1
          p "You've reached me!"

        when 2
          require 'launchy'
          Launchy.open("https://darksky.net/dev/register")

        when 3
          require 'clipboard'
          Clipboard.copy(@weather_api_reg)

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
        @prompt = TTY::Prompt.new
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