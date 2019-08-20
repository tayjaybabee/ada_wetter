module AdaWetter
  class Application
    class VLogger
      
      # See error_codes.md to find out more about this error
      
      class UnknownLevelArgument < StandardError
        attr_accessor :message, :hint, :code, :full_message
        def message
          'VLogger received incorrect level argument'
        end
        
        def hint
          'Valid arguments: info, warn, ok, error'
        end
        
        def code
          0202 # You can reference this code in 'docs/error_codes.md' with this code
        end
        
      end
      
      def self.message(caller, msg, level = 'info', force = false)
        msg = "[#{Time.now.strftime("%Y-%m-%d %H:%M:%S.%L")}] - [#{caller}] - #{msg}"
        begin
          if VERBOSE or force
          end
          case level
            when 'info'
              PROMPT.say msg
            when 'ok'
              PROMPT.ok msg
            when 'error'
              PROMPT.error msg
            when 'warn'
              PROMPT.warn msg
            else
              raise UnknownLevelArgument
            end
        rescue UnknownLevelArgument => e
          p e.full_message
        end
        
      end
    end
  
  end
end