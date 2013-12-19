$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "attr_enum_accessor/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "attr_enum_accessor"
  s.version     = AttrEnumAccessor::VERSION
  s.authors     = ["Gerry Shaw"]
  s.email       = ["gshaw@venturemedia.com"]
  s.homepage    = "https://github.com/gshaw/attr_enum_accessor"
  s.summary     = "Enumerated fields stored using integers"
  s.description = "ActiveRecord plugin to efficienty store enumerated fields."

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE.txt", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "guard-minitest"
end
