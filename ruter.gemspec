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

  s.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.executables = s.files.grep(%r{^exe/}).map { |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "rack", "~> 2.0"
  s.add_dependency "syro", "~> 3.2"
  s.add_dependency "tilt", "~> 2.0"
  s.add_dependency "erubi", "~> 1.10"
  s.add_development_dependency "minitest", "~> 5.8"
  s.add_development_dependency "minitest-sugar", "~> 2.1"
  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency "standard", "~> 1.2"
end
