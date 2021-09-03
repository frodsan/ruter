require_relative "lib/ruter/version"

Gem::Specification.new do |spec|
  spec.name = "ruter"
  spec.version = Ruter::VERSION
  spec.authors = ["Francesco Rodriguez"]
  spec.email = "frodsan@me.com"

  spec.summary = "Ruter routes your HTTP requests 🚌"
  spec.description = "Rack based web framework built on top of Syro"
  spec.homepage = "https://github.com/frodsan/ruter"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  spec.files = `git ls-files`.split("\n")
  spec.executables = spec.files.grep(%r{^exe/}).map { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rack", "~> 2.0"
  spec.add_dependency "syro", "~> 3.2"
  spec.add_dependency "tilt", "~> 2.0"
  spec.add_dependency "erubi", "~> 1.10"
end
