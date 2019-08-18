module AdaWetter
  class Application
    require 'ada_wetter/common/application/error'
    module Opts
      
      @verbose = nil
      
      def self.success(opt)
        PROMPT.ok "Applied the #{opt} flag to options"
        PROMPT.say "Options state: #{OPTIONS}"
      end
      
      def self.announce(opt)
        PROMPT.ok "Found #{opt} flag..."
        PROMPT.say 'Applying to options...'
      end
      
      def self.loader(opts)
        @verbose = VERBOSE if defined? VERBOSE
        PROMPT.ok "Loader received load command with options: #{opts}" if @verbose
        PROMPT.say 'Checking sanity of provided flags...'
        if opts.wizard and opts.shell
          # @raise [ArgumentError::ArgumentMismatchError] if two (or more) arguments logically or programmatically
          #   can't be executed when called at the same time. Please choose one, see documentation and try again!
          raise ArgumentError::ArgumentMismatchError
        end
        if opts.wizard
          name = '--wizard'
          announce(name)
          OPTIONS[:wizard] = true
          success(name)
        end
        if opts.clean
          name = '--clean'
          announce(name)
          OPTIONS[:clean] = true
          success(name)
        end
      end
    
    end
  end
end
