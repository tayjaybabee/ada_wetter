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
    
    module Error
    
    
    
    end

  end
end
