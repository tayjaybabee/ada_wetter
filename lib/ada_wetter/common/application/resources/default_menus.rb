module AdaWetter
  class Application
    module DefaultMenus
      
      @nyi = 'Not yet implemented'
      
      def global_menu_options
        %w('quit', 'Open documentation in browser')
      end
      
      def onboarder_ynq
        choices = ['yes', 'no', 'quit', 'configure w/ default options']
        choice = PROMPT.enum_select 'Would you like to be taken to the onboarder?'
        PROMPT.select 'How would you like to proceed?' do |m|
          m.choice name: 'Configure with Configuration Wizard', value: 1
          m.choice name: 'Configure with Shell', value: 2, disabled: @nyi
          m.choice name: 'Install default conf file', value: 3, disabled: @nyi
          m.choice name: 'Import conf file from previous install', value: 4, disabled: @nyi
        
        end
      end
      
    end
  end
end