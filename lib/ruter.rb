require_relative "ruter/version"
require_relative "ruter/plugin"
require_relative "ruter/core"
require_relative "ruter/middleware"
require_relative "ruter/settings"

class Ruter
  extend Ruter::Plugin

  # Internal: Core plugins.
  plugin(Ruter::Core)
  plugin(Ruter::Middleware)
  plugin(Ruter::Settings)
end
