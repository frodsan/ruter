class Ruter
  # Public: It provides a settings API for Ruter applications.
  #
  # Examples
  #
  #   require "ruter"
  #
  #   module AppName
  #     def self.setup(app, app_name)
  #       app.settings[:app_name] = app_name
  #     end
  #
  #     module ClassMethods
  #       def app_name
  #         return settings[:app_name]
  #       end
  #     end
  #   end
  #
  #   Ruter.plugin(AppName, "MyApp")
  #
  #   Ruter.app_name
  #   # => "MyApp"
  #
  module Settings
    # Internal: Returns a deep copy of a Hash.
    def self.deepclone(hash) # :nodoc:
      default_proc, hash.default_proc = hash.default_proc, nil

      Marshal.load(Marshal.dump(hash))
    ensure
      hash.default_proc = default_proc
    end

    module ClassMethods
      # Internal: Copies settings into the subclass.
      # If a setting is not found, checks parent's settings.
      def inherited(subclass)
        subclass.settings.replace(Ruter::Settings.deepclone(settings))
        subclass.settings.default_proc = proc { |h, k| h[k] = settings[k] }
      end

      # Public: Sets an +option+ to the given +value+.
      #
      # Examples
      #
      #   Ruter.set(:environment, :staging)
      #
      #   Ruter.environment
      #   # => :staging
      #
      def set(option, value)
        settings[option] = value
      end

      # Returns a Hash with the application settings.
      #
      # Examples
      #
      #   Ruter.set(:environment, :development)
      #
      #   Ruter.settings
      #   # => { :environment => :development }
      #
      def settings
        @settings ||= {}
      end
    end

    module InstanceMethods
      # Returns a Hash with the application settings.
      #
      # Examples
      #
      #   Ruter.set(:environment, :development)
      #
      #   Ruter.define do
      #     get do
      #       res.write(settings[:environment])
      #     end
      #   end
      #
      #   GET / # => 200 "development"
      #
      def settings
        self.class.settings
      end
    end
  end
end
