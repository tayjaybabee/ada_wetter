require 'ada_wetter/helpers/error'
module Configure
  
  class ConfigError < StandardError
    attr_accessor :message, :hint
    
    def message
      'Configuration error'
    end
    
    def hint
      'Please see documentation if error persists'
    end
    
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
  
  def self.start_wizard
    require 'ada_wetter/commands/configure/wizard'
    require 'ada_wetter/common/database'
    self::Wizard.start
  end
end