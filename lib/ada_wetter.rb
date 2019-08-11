module AdaWetter
  class Application
    require 'ada_wetter/helpers/network'
    require 'ada_wetter/commands/configure/common/database'
    require 'tty-prompt'

    @prompt = TTY::Prompt.new

    def self.config
      database = AdaWetter::Application::Configure::Database
      if database.check_file
        conf = database.readout
      else
        if @prompt.yes? 'No configuration file found, should I create one? (y/n)'
          conf = database.create
        end
        conf
      end
    end

    @@settings = config

    def self.settings
      @@settings
    end
    
    class Error
    
      # A class to provide information if the end-user should stumble upon and try to use a feature that is not-yet-
      # implemented
      class OptionNotImplementedError < Error
        attr_accessor :message, :hint, :code
        
        def message
          "The option you are trying to use hasn't been implemented yet!"
        end
        
        def hint
          "Please see documentation!"
        end
        
        def code
          88
        end
        
      end
    
    end

  end
end
