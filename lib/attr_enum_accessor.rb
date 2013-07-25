# Provides a method to allow models to access enumerated values
module AttrEnumAccessor
  extend ActiveSupport::Concern

  module ClassMethods
    # Provides easy accessors for enumerated fields stored as integers in database.
    #
    # Requires a column in the model to have :name_value (override with `:value_column` option)
    #
    # Example:
    #
    #   class User < ActiveRecord::Base
    #     ROLE = {
    #       user:   1,
    #       editor: 2,
    #       admin:  3
    #     }
    #
    #     include AttrEnumAccessor
    #     attr_enum_accessor :role, with: ROLE
    #     attr_enum_accessor :status, with: STATUS, value_column: :status_number, exclude_scope: true
    #
    #   end
    #
    #   u = User.new
    #   u.role = :admin
    #   u.role # => :admin
    #   u.role_value # => 3
    #
    #   User.where_role(:admin).count                 # all admins
    #   User.where_role([:editor, :admin]).count      # all editors and admins
    #   User.where_role(ROLE.keys - [:admin]).count   # all except admins
    #
    #   User.role_to_value(:admin)            # => 3
    #   User.role_to_value([:editor, :admin]) # => [2, 3]
    #
    def attr_enum_accessor(enum_attribute, options = {})
      enum_values = options[:with]
      value_column = options[:value_column] || :"#{enum_attribute}_value"
      raise ArgumentError.new("Required option `with` must be a Hash") unless enum_values.kind_of?(Hash)

      define_singleton_method(:"#{enum_attribute}_to_value") do |value|
        values = Array(value).flatten.map do |value|
          enum_values[value.to_sym] or raise ArgumentError.new("Invalid #{enum_attribute} `#{value}`")
        end
        values.count == 1 ? values.first : values
      end

      define_singleton_method(:"where_#{enum_attribute}") do |value|
        values = send(:"#{enum_attribute}_to_value", value)
        where(value_column => values)
      end unless options[:exclude_scope]

      define_method(enum_attribute) do
        enum_values.key(read_attribute(value_column))
      end

      define_method(:"#{enum_attribute}=") do |value|
        write_attribute(value_column, self.class.send(:"#{enum_attribute}_to_value", value))
      end
    end
  end
end
