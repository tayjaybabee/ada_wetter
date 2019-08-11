module AdaWetter
  class Application
    module Configure

      class ConfigError < Application::Error
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

      def self.start_wizard(opts)
        require 'ada_wetter/commands/configure/wizard'
        require 'ada_wetter/commands/configure/common/database'
        wiz = AdaWetter::Application::Configure::Wizard
        wiz.new(opts)
      end
    end
  end
end