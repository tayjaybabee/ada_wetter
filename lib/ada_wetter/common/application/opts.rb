module AdaWetter
  class Application
    module Opts
      
      @verbose = nil
      
      def self.success(opt)
        LOG.message self, "Applied the #{opt} flag to options", 'ok'
        LOG.message self, "Options state: #{OPTIONS}", 'ok'
      end
      
      def self.announce(opt)
        LOG.message self, "Found #{opt} flag...", 'ok'
        LOG.message self, 'Applying to options...'
      end
      
      def self.loader(opts)
        LOG.message self, "Loader received load command with options: #{opts}", 'ok'
        LOG.message self, 'Checking sanity of provided flags'
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
