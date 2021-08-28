require_relative "lib/ruter/version"

Gem::Specification.new do |s|
  s.name = "ruter"
  s.version = Ruter::VERSION
  s.summary = "Another Rack based web framework 🤷🏽‍♂️"
  s.description = s.summary
  s.author = "Francesco Rodriguez"
  s.email = "frodsan@me.com"
  s.homepage = "https://github.com/frodsan/ruter"
  s.license = "MIT"

  s.files = Dir["LICENSE", "README.md", "lib/**/*.rb"]
  s.test_files = Dir["test/**/*.rb"]

  s.add_dependency "rack", "~> 2.0"
  s.add_dependency "syro", "~> 3.2"
  s.add_dependency "tilt", "~> 2.0"
  s.add_dependency "erubi", "~> 1.10"
  s.add_development_dependency "minitest", "~> 5.8"
  s.add_development_dependency "minitest-sugar", "~> 2.1"
  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency "standard", "~> 1.2"
end
