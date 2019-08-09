# frozen_string_literal: true

module AdaWetter
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class Application
    require 'commander/import'
    # Error raised by this runner
    Error = Class.new(StandardError)

    require "ada_wetter/version"
    require 'tty-prompt'
    require 'ada_wetter/helpers/error'
    
    @@prompt = TTY::Prompt.new

    program :name, 'ada_wetter'
    program :version, '0.0.1'
    program :description, 'An applet for the Wetter module of the AIDA system'
    #program :help_formatter, :compact

    global_option '-v', '--verbose', 'Provides (sometimes) useful data when program fails'
    global_option '-c', '--config-import FILE', 'Give ada_wetter the location of an previously-made conf file'
    global_option '-d', '--install-default-conf', 'Installs unconfigured conf file and directory'

    default_command :run
    
    command :run do |c|
      c.syntax      = 'ada_wetter <run> [options]'
      c.summary     = 'Runs the applet.'
      c.description = 'Delivers local weather data and data from sensors'
      c.example c.summary 'ada_wetter --trace --verbose'
      c.option '-g', '--gui', "Starts AdaWetter's GUI instead of the command line utility"
      c.action do |args, options|
        arg_check(options)
        if options.install-default-conf
          if options.config-import
            @@prompt.error 'You cannot both import a config file and install the default.'
            raise ArgumentConflictError
          end
          require 'ada_wetter/commands/configure/common/database'
          db = Configure::Database
          
          unless db.check_file
          
          end
        end
      rescue ArgumentConflictError => e
        @@prompt.error e.full_message
        exit(10022)
      end
      
    end


    command :onboarder do |c|
      c.syntax      = 'ada_wetter onboarder [options]'
      c.summary     = 'Provides a basic overview of configuration needs, and also API links.'
      c.description = ''
      c.example 'description', 'command example'
      c.option '-L', '--all-links', 'Will provide all API service links (for docs and API key signup'
      c.option '-wa', '--weather-api-overview', 'Will provide an overview of docs and important links for the weather API'
      c.option '-ga', '--geocode-api-overview', 'Will provide an overview of docs and important links for the geocoding API'
      c.action do |args, options|
        
        choices = [
          {name: 'Shell', disabled: '[Not yet implemented]'},
          'Wizard',
        ]
        require 'ada_wetter/commands/configure'
        AdaWetter::Application::Configure.start_wizard(options)

      end
    end

    command :configure do |c|
      c.syntax      = 'ada_wetter configure [options]'
      c.summary     = ''
      c.description = ''
      c.example 'description', 'command example'
      c.option '-O', '--override_port PORTNUM', Integer, 'Override the default port ada_wetter seeks to connect to'
      c.option '--api-key STRING', String, 'Provides an API key for ada_wetter to use to fetch weather'
      c.option '--geocode STRING', String, 'Provides location data for ada_wetter to use to fetch weather'
      c.option '-s', '--shell', 'Start a shell for configuration'
      c.option '-w', '--wizard', 'Start the configuration wizard tool'
      c.action do |args, options|
        say 'foo' if options.verbose
        say 'Checking options as provided'


        if options.shell and options.wizard
          say 'You cannot run both the shell and wizard configuration tools at once!'
        end

        if options.shell
          Configure::Shell.new
        end

        if options.wizard
          AdaWetter::Configure::Wizard.new
        end

        onboarder = AdaWetter::Configure::Wizard::Onboarder.new
        onboarder

      end

    end

    command :gui do |c|
      c.syntax      = 'ada_wetter gui [options]'
      c.summary     = ''
      c.description = ''
      c.example 'description', 'command example'
      c.option '--some-switch', 'Some switch that does something'
      c.action do |args, options|
        # Do something or c.when_called Ada_wetter::Commands::Gui
      end
    end

    command :cli do |c|
      c.syntax      = 'ada_wetter cli [options]'
      c.summary     = ''
      c.description = ''
      c.example 'description', 'command example'
      c.option '--some-switch', 'Some switch that does something'
      c.action do |args, options|
        Weather::Shell.new

      end
    end

    command :install do |c|
      c.syntax      = 'ada_wetter install [options]'
      c.summary     = ''
      c.description = ''
      c.example 'description', 'command example'
      c.option '--some-switch', 'Some switch that does something'
      c.action do |args, options|
        if Configure.check_conf?
          say 'Continuing with install'
        else
          system('clear')
          say 'You need to go back and run a configure tool'
          say "For Example: ./ada_wetter configure (--wizard|-sh)"
        end
        # Do something or c.when_called Ada_wetter::Commands::Install
      end
    end
  end
end
