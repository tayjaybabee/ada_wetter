require 'ada_wetter/helpers/network'
module AdaWetter
  class Application
    
    # A library holding namespaces/aliases/definitions for different application errors
    # # You can see error_codes.md for more information regarding the codes found here
    # # without digging through code, if you want. However, I encourage you to get to know
    # # the code
    class Error
    
      # Catch-all exception class for unforeseen exceptions raised due to being unable to parse arguments
      class ArgumentError < StandardError
        
        # These codes will hopefully allow for a system of quick-access code lookup can be achieved through Ruby on Rails
        # However, even without that that being implemented one could always Ctrl+f :)
        def code
          code = 10022
        end
        
        def message
          'Argument error!'
        end
      
        def hint
          'Please see documentation!'
        end
      
        def full_message
          "#{code} || #{message} | #{hint}"
        end
        
        # If the program is passed two options which conflict logically with each-other the following exception class
        # will be raised, in an effort to advise the end user how to proceed
        class ArgumentConflictError <  ArgumentError
          
          def initialize
          
          end
        
          def code
            code = 1639
          end
          
          def message
            'One or more arguments conflict with each-other!'
          end
          
          def hint
            'Check your arguments (or documentation if need-be) and try again.'
          end
          
          # FIXME: The string concatenate process should only be defined once 08/10/19 -tjb/
          def full_message
            "#{code} || #{message} | #{hint}"
          end
          
        end
        
        class InvalidArgumentError < ArgumentError
        
          def code
            code = 22
          end
          
        end
      end
      
        
    end
  end
end

