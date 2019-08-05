require 'open-uri'

module AdaWetter
  class Application

    module Network

      class Error < StandardError
        class NoConnectionError < Error
          attr_reader :message

          def initialize(message='No internet connection found')
            @message = message
            @hint = 'Restore connection and try again.'
          end
        end
      end

      def self.connected?
        require "resolv"
        dns_resolver = Resolv::DNS.new
        begin
          dns_resolver.getaddress("symbolics.com")#the first domain name ever. Will probably not be removed ever.
          return true
        rescue Resolv::ResolvError => e
          return false
        end
      end

    end

  end
end