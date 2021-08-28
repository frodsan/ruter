class Ruter
  # Public: Ruter's middleware system.
  module Middleware
    module ClassMethods
      # Public: Adds given Rack +middleware+ to the stack.
      #
      # Examples
      #
      #   require "rack/common_logger"
      #   require "rack/show_exceptions"
      #
      #   Ruter.use(Rack::CommonLogger)
      #   Ruter.use(Rack::ShowExceptions)
      #
      def use(middleware, *args, &block)
        self.middleware << proc { |app| middleware.new(app, *args, &block) }
      end

      # Internal: Returns middleware stack.
      def middleware # :nodoc:
        @_middleware ||= []
      end

      # Internal: Used for internal testing.
      def reset! # :nodoc:
        super
        @_middleware = []
      end

      # Internal: Overrides app composition from core.
      private def build_app(syro)
        @_app = if middleware.empty?
          syro
        else
          middleware.reverse.inject(syro) { |a, m| m.call(a) }
        end
      end
    end
  end
end
