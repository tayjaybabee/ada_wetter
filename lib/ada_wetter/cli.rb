# Namespace and launch library of AdaWetter
# @since 0.0.1a1.0
module AdaWetter
  require 'ada_wetter/common/application'

  # Base class for AdaWetter application, both CLI and GUI. This class
  # acts as the skeleton for the whole program
  #
  # @author Taylor-Jayde J. Blackstone
  # @since 0.0.1rc1.3
  # @attr [Types] attribute_name a full description of the attribute
  # @attr_reader [Types] name description of a readonly attribute
  # @attr_writer [Types] name description of writeonly attribute
  class Application
    # Handle the application command line parsing
    # and the dispatch to various command objects
    #
    # @api public
    require 'commander/import'
    #require 'ada_wetter/common/runtime'
    
    
    require 'ada_wetter/version'
    require 'ada_wetter/helpers/error'
    
    # program :help_formatter, :compact
    program :name, 'ada_wetter'
    program :version, '0.0.1'
    program :description, 'An applet for the Wetter module of the AIDA system'
    
    global_option '-v', '--verbose', 'Provides (sometimes) useful data when program fails' do
      OPTIONS[:verbose] = true
      require 'ada_wetter/common/application/verbose'
      @verbose = true
    end
    global_option '-c', '--config-import FILE', 'Give ada_wetter the location of an previously-made conf file'
    global_option '-d', '--install-default-conf', 'Installs unconfigured conf file and directory'
    
    global_option '--allowClear'
    
    default_command :run
    
    command :run do |c|
      c.syntax      = 'ada_wetter <run> [options]'
      c.summary     = 'Runs the applet.'
      c.description = 'Delivers local weather data and data from sensors'
      c.example 'description', 'command example'
      c.option '-g', '--gui', "Starts AdaWetter's GUI instead of the command line utility"
      c.option '--no-option'
      c.action do |args, options|
        
        
        if options.install_default_conf
          db = Configure::Database
          db.create
        end
      
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
      c.option '--clean', "Remove all config files"
      c.action do |args, options|
        PROMPT.ok "Caught verbose flag!" if @verbose
        PROMPT.say "Received the following options: #{options}" if @verbose
        PROMPT.say "Elevating flags..." if @verbose
        require 'ada_wetter/common/application/opts'
        include Opts
        begin
          Opts.loader(options)
        rescue ArgumentError::ArgumentMismatchError => e
          e.full_message
          PROMPT.yes? 'Would you like me to take you to the '
        end
        
        if options.wizard
          PROMPT.ok 'All good! Starting wizard!' if @verbose
          require 'ada_wetter/commands/configure/wizard'
        end
        
      
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
