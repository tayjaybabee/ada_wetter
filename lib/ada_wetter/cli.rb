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
  #
  #
  class Application
    
    require 'commander/import' # Provides command parsing for CLI- based programs
    require 'ada_wetter/version' # Contains version information for AdaWetter
    
    # If we have a pre-release version of AdaWetter we want that to reflect in the information delivered when the end-
    # user triggers the '--help' (or '-h') option.
    #
    desc = 'An applet for the Wetter module of the AIDA system'
    
    if AdaWetter::PRERELEASE
      type = PR_TYPE.capitalize
      desc = "(Pre-release: #{type}) - #{desc}"
    end
    
    # Using Commander's DSL below we provide the name, version, and description of the program which will be available
    # to be parsed at various times when called throughout the program. (For example; when you use the '--help' flag)
    
    program :name, 'ada_wetter'
    program :version, AdaWetter::HUM_VER
    program :description, desc
    
    # Specify some global options (and what to do if these options are used)
    
    global_option '-v', '--verbose', 'Provides (sometimes) useful data when program fails' do
      OPTIONS[:verbose] = true
      require 'ada_wetter/common/application/verbose'
      @verbose = true
      LOG = VLogger
    end
    global_option '-d', '--install-default-conf', 'Installs unconfigured conf file and directory'
    
    global_option '--import-conf FILE', 'Import a config file from a previous installation of AdaWetter. FILE required'
    global_option '--write-log FILE', 'Instructs the program to write all output to a file. FILE required'
    
    global_option '--allow-clear', 'Provide the program with permission to clear terminal screen'
    
    # If the user does not specify an AdaWetter command when calling the binary we will run the 'run' command by default
    # as this command includes all pre-runtime configuration checks needed to ensure a stable running environment.
    
    default_command :run
    
    # This command is the default command for AdaWetter and will run either the CLI version of the program or (if you
    # use the '--gui' flag) the GUI version. NOTE: the '--gui' flag currently only works on the 'run' command!
    #
    # For example: ada_wetter --verbose run --gui
    #   > GUI version of AdaWetter opens*
    #
    # * If your environment is not properly set-up you will not (at least as of this writing) be presented with any GUI
    #   windows or dialog boxes. Check your terminal (if not already watching it) to ensure the program isn't waiting for
    #   your input to continue.
    #     TODO: Create GUI configuration wizard and control panel that will be accessible from within the GUI's preferences menu as well as from the command line (without triggering the entirety of the program whilst doing so)
    #
    #     TODO: Provide pop-up modal dialog box that report start-up exceptions/notifications/warnings when Adawetter is run
    
    command :run do |c|
      c.syntax      = 'ada_wetter <run> [options]'
      c.summary     = 'Runs the applet.'
      c.description = 'Delivers local weather data and data from sensors'
      c.example 'Typical usage:', 'ada_wetter --verbose --trace --gui'
      c.option '-g', '--gui', "Starts AdaWetter's GUI instead of the command line utility"
      c.option '--no-option'
      c.action do |args, options|
      
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
      c.option '--clean', "Remove all config files. Calling any other arguments other than verbose with this will result in an error"
      c.action do |args, options|
        
        LOG.message self,"Caught verbose flag!", 'ok'
        LOG.message self, "Received the following options: #{options.inspect}"
        LOG.message self, "Elevating flags..."
        require 'ada_wetter/common/application/opts'
        require 'ada_wetter/common/application/error'
        include Opts
        begin
          Opts.loader(options)
        rescue Error::ArgumentError::ArgumentMismatchError => e
          ask_ob = PROMPT.yes? 'Would you like me to take you to the OnBoarder? (y/n) >'
          if ask_ob
            LOG.message self, 'User indicated desire to use onboarder. Starting...', 'ok'
            # start onboarder
          else
            LOG.message self, 'User replied negatively, exiting with advice...', 'warn'
            LOG.message self, 'User declined onboarder, no options. Exiting', 'error'
            e.full_message0
            exit e.code
          end
        end
        
        if options.wizard
          LOG.message self, 'All good, starting wizard!', 'ok'
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
