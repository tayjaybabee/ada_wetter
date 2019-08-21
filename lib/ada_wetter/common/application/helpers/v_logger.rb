module AdaWetter
  class Application
    class VLogger
      
      # See error_codes.md to find out more about this error
      #
      # @author Taylor-Jayde J. Blackstone <t.blackstone@inspyre.tech>
      # @since 0.1.0.4
      
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
        
        def full_message
        
        end
      end
      
      
      # Method to assemble and deliver log/verbose console messages from various parts of the program while keeping track
      # of two things:
      #   1. Is the program in verbose mode:
      #   2. Is the program set to log to a file? If it is, then the force argument should be true and it will write it
      #
      # TODO: Write the write_log method to be used when the user calls the "--write-log" option flag on any command.
      
      def self.message(caller, msg, level = 'info', force = false)
        msg = "[#{Time.now.strftime("%Y-%m-%d %H:%M:%S.%L")}] - [#{caller}] - #{msg}"
        begin
          if VERBOSE or force
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
          end
        rescue UnknownLevelArgument => e
          LOG.message self, e.full_message
        end
      end
    
    end
  end
end
