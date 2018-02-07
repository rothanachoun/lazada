# coding: utf-8
require 'lazada/version'

Gem::Specification.new do |spec|
  spec.name          = "lazada"
  spec.version       = Lazada::VERSION
  spec.authors       = ["Rothana Choun"]
  spec.email         = ["rothana@yoolk.com"]

  spec.summary       = %q{A ruby wrapper for the Lazada API.}
  spec.description   = %q{A ruby wrapper for the Lazada API.}
  spec.homepage      = "https://github.com/yoolk/lazada"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "builder", '~> 3.2'
  spec.add_dependency "httparty", "~> 0.15.6"
  spec.add_dependency "addressable", "~> 2.5.2"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.required_ruby_version = '>= 2.3.0' # minimum ruby 2.3.0
end
