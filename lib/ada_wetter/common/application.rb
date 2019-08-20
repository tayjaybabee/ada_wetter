require 'ada_wetter/common/application/opts'
require 'ada_wetter/common/application/settings'
require 'ada_wetter/common/application/helpers/error'
require 'ada_wetter/common/application/helpers/key_events'
require 'tty-prompt'
module AdaWetter
  
  class Application
    
    include Settings
    
    OPTIONS = {}
    PROMPT = TTY::Prompt.new
    
    def log(msg)
    
    end
    
    def self.set_verbose
    
    end
    
    def self.set_options(opts)
      OPTIONS[:opts] = opts
      p OPTIONS[:opts]
    end
  end
end
