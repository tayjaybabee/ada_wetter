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
        LOG.message self, "Loader received load command with options: #{opts.inspect}", 'ok'
        LOG.message self, 'Checking sanity of provided flags'
        if opts.wizard and opts.shell
          # @raise [ArgumentError::ArgumentMismatchError] if two (or more) arguments logically or programmatically
          #   can't be executed when called at the same time. Please choose one, see documentation and try again!
          raise ArgumentMismatchError
        end
        if opts.install_default_conf and opts.import_conf
          # @raise [ArgumentError::ArgumentMismatchError] if two (or more) arguments logically or programmatically
          # can't be executed when called at the same time. Please choose one, see documentation and try again!
          raise ArgumentMismatchError
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
        if opts.install_default_conf
          name = '--install-default-conf'
          announce(name)
          OPTIONS[:install_default_conf] = true
          success(name)
          LOG.message self, 'Starting conf installation function....'
          require 'ada_wetter/commands/configure'
          Configure.install_def_conf
        end
      end
    
    end
  end
end
