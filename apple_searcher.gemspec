# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apple_searcher/version'

Gem::Specification.new do |spec|
  spec.name          = "apple_searcher"
  spec.version       = AppleSearcher::VERSION
  spec.authors       = ["alekseenkoss"]
  spec.email         = ["alekseenkoss@gmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "Parse additional information about Apple devices in Parser class."
  end

  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
  spec.add_dependency "faraday"
  spec.add_dependency "faraday-cookie_jar"
end
