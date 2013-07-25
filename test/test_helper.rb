# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require 'test/unit'
require 'active_support'
require 'test_base_model'

require 'attr_enum_accessor'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
