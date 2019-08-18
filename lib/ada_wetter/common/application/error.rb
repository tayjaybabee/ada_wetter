module AdaWetter
  class Application
    
    class ArgumentError < StandardError
      attr_accessor :message, :hint, :code, :full_message
      
      def message
        'There was a problem with your argument(s)'
      end
      
      def hint
        'Please check the documentation and try your command again.'
      end
      
      def code
        0101
      end
      
      class ArgumentMismatchError < ArgumentError
        attr_accessor :message, :hint, :code, :full_message
        
        def message
          'Two (or more) of your arguments are conflicting'
        end
        
        def hint
          'Please see the documentation and try again.'
        end
        
        def code
          0102
        end
        
        def full_message
          PROMPT.warn "#{code} | #{message} + #{hint}"
        end
      end
    
    end
  end

end
