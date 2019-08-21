require 'ada_wetter/common/application/error'
require 'tty-config'
module AdaWetter
  class Application
    
    # The configure module is a library holding everything needed for the configuration functions of AdaWetter. While it
    # in itself is not a class, it holds a few classes (exceptions and processes) and library modules of it's own.
    #
    # @author Taylor-Jayde J. Blackstone <t.blackstone@inspyre.tech>
    # @since 0.1.0.4
    #
    # @note There are two new exception classes within this module introduced to the program environment to be utilized by any other
    #    part of AdaWetter
    
    module Configure
      
      # This exception-class sets up AdaWetter::Application::ConfigError which inherits StandardError (a ruby-native exception
      # class)
      #
      # @author Taylor-Jayde J. Blackstone <t.blackstone@inspyre.tech>
      # @since 0.1.0.3
      
      class ConfigError < StandardError
        attr_accessor :message, :hint, :code, :fu
        
        def message
          'Configuration error'
        end
        
        def hint
          'Please see documentation if error persists'
        end
        
        # Class for ConfigError::GeocodeError which is raised if Application::Geocoder is unable to find results for a
        # given query
        #
        # @author Taylor-Jayde J. Blackstone <t.blackstone@inspyre.tech>
        # @since 0.1.0.4
        
        class GeocodeError < ConfigError
          attr_accessor :message, :hint
          
          def message
            'Geocoder unable to find results'
          end
          
          def hint
            'Please check your query and try it again.'
          end
        
        end
      
      end
      
      # Method to start the configuration wizard class which will walk the end-user through AdaWetter configuration
      #
      # @author Taylor-Jayde J. Blackstone <t.blackstone@inspyre.tech>
      # @since 0.1.0.4
      #
      
      def self.start_wizard
        require 'ada_wetter/commands/configure/wizard'
        require 'ada_wetter/common/database'
        self::Wizard.start
      end
      
      # Method to install a config file with the default options in 'PROGRAM_ROOT/conf/settings.conf'
      #
      # @author Taylor-Jayde J. Blackstone <t.blackstone@inspyre.tech>
      # @since 0.1.0.4
      #
      
      def self.install_def_conf
        LOG.message self, 'Received command to install default config file...', 'ok'
        LOG.message self, 'Loading default config template...'
        require 'ada_wetter/common/application/resources/conf_structs/settings'
        settings = Settings.temp_settings
        LOG.message self, 'Attempting to load into configuration for application...'
        begin
          require 'pathname'
          config = TTY::Config.coerce(settings)
          config_h = config.to_h
          LOG.message self, "Success! Loaded configuration state: #{config_h}", 'ok'
          settings = config_h[:settings]
          c_filename = settings[:settings_file].to_s
          c_extname = settings[:settings_ext].to_s
          c_filename_full = "#{c_filename}#{c_extname}"
          LOG.message self, "Recorded settings file name as #{c_filename_full}", 'ok'
          c_path = settings[:conf_path]
          c_filepath = "#{c_path}#{c_filename_full}"
          LOG.message self, "Conffile pathname reads as: #{c_filepath}", 'ok'
          
          c_path = config.fetch :settings, :conf_path
          c_path = Pathname(c_path)
          c_extname = config.fetch [:settings, :settings_ext]
          p config.fetch 'settings.settings_ext'
          config.filename= c_filename
          config.append_path c_path
          config.extname= c_extname
          dir_check = File.directory? c_path
          while !dir_check
            require 'pathname'
            LOG.message self, "Unable to find specified directory #{c_path}", 'warn', true
            confirm_write = PROMPT.yes? "Would you like me to create #{c_path} for you? (y/N) $>"
            if confirm_write
              File.mkdir c_path
            else
              LOG.message self, 'Program unable to write configuration file. Please create the directory and try again', 'error', true
            end
          end
          config.write
          p config.read
        end
        
      end
    
    end
  end
end
