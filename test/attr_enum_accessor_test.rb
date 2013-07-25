require 'test_helper'

class User < TestBaseModel
  ROLE = {
    user: 1,
    admin: 2,
  }

  include AttrEnumAccessor
  attr_enum_accessor :role, with: ROLE
end

class AttrEnumAccessorTest < ActiveSupport::TestCase
  test "role_to_value" do
    assert_equal 1, User.role_to_value(:user)
    assert_equal 2, User.role_to_value(:admin)
  end

  test "accessors" do
    u = User.new
    u.role = :admin
    assert_equal :admin, u.role
    assert_equal 2, u.read_attribute(:role_value)

    u.write_attribute(:role_value, 1)
    assert_equal :user, u.role
  end

  test "raise error on invalid value" do
    begin
      u = User.new
      u.role = :unknown
      assert false, "should have thrown error"
    rescue ArgumentError => ex
      assert_equal "Invalid role `unknown`", ex.to_s
    end
  end

  test "where helper" do
    User.where_role(:admin)
    assert_equal User.where_options, { role_value: 2 }

    User.where_role([:user, :admin])
    assert_equal User.where_options, { role_value: [1, 2] }
  end
end
