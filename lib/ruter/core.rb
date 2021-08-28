require "rack"
require "syro"
require_relative "core/request"
require_relative "core/response"

class Ruter
  # Include Syro's API directly instead of using the plugin
  # system to be able to override any of its methods.
  include Syro::Deck::API

  # Internal: Handles Syro integration.
  module Core
    module ClassMethods
      # Public: Sets the application handler.
      #
      # Examples
      #
      #   class Users < Ruter
      #   end
      #
      #   Users.define do
      #     on(:id) do |id|
      #       get do
      #         res.write("GET /users")
      #       end
      #
      #       post do
      #         res.write("POST /users")
      #       end
      #     end
      #   end
      #
      def define(&block)
        build_app(Syro.new(self, &block))
      end

      private def build_app(syro)
        @_app = syro
      end

      # Internal: Required by the Syro API.
      def implement(&code) # :nodoc:
        Class.new(self) do
          define_method(:dispatch!, code)

          private :dispatch!

          define_method(:inspect) do
            self.class.superclass.inspect
          end
        end
      end

      # Internal: Required by the Rack API.
      def call(env) # :nodoc:
        @_app.call(env)
      end

      # Internal: Used for internal testing.
      def reset! # :nodoc:
        @_app = nil
      end
    end

    module InstanceMethods
      def request_class # :nodoc:
        Ruter::Core::Request
      end

      def response_class # :nodoc:
        Ruter::Core::Response
      end
    end
  end
end
