module Error
  
  class DatabaseError < Configure::ConfigError; end

  class NetworkError < Network::Error::NoConnectionError; end
  
  class ArgumentError < StandardError
    
    def message
      'Argument error!'
    end
    
    def hint
      'Please see documentation!'
    end
    
    def full_message
      "#{code} || #{message} | #{hint}"
    end

    def code
      code = 10022
    end
    
    class ArgumentConflictError < ArgumentError
      
      def message
        'Two (or more) of your arguments are conflicting!'
      end
      
      def hint
        'Please see the documentation and/or try again!'
      end
      
      def full_message
        "#{code}|| #{message} | #{hint}"
      end
      
      def code
        code = 1639
      end
      
      
      
    end
    
  end
  
end