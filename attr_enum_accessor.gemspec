# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'attr_enum_accessor/version'

Gem::Specification.new do |spec|
  spec.name          = "attr_enum_accessor"
  spec.version       = AttrEnumAccessor::VERSION
  spec.authors       = ["Gerry Shaw"]
  spec.email         = ["gshaw@reinvent.com"]
  spec.summary       = %q{Enumerated fields stored using integers}
  spec.homepage      = "https://github.com/gshaw/attr_enum_accessor"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 1.9"

  spec.add_dependency "activesupport", ">= 3.2"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit"
  spec.add_development_dependency "guard-test"
end
