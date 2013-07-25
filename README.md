# AttrEnumAccessor

[![Build Status](https://travis-ci.org/gshaw/attr_enum_accessor.png?branch=master)](https://travis-ci.org/gshaw/attr_enum_accessor)
[![Gem Version](https://badge.fury.io/rb/attr_enum_accessor.png)](http://badge.fury.io/rb/attr_enum_accessor)

Store enumerated attributes in your database as integers while using type
checked symbols in code.

[RubyDoc Documentation](http://rubydoc.info/github/gshaw/attr_enum_accessor/master/frames)

## Usage

Create integer columsn with `_value` suffix to store enumerated attribute values.

    class CreateUsers < ActiveRecord::Migration
      def change
        create_table :users do |t|
          t.string :email, null: false
          t.string :password_digest
          t.integer :role_value, null: false, default: 0
          t.timestamps
        end
      end
    end

Create a hash in your model to map symbols to enumerated attribute values.

    class User < ActiveRecord::Base
      ROLE = {
        user:  0,
        admin: 1,
      }

      include AttrEnumAccessor
      attr_enum_accessor :role, with: ROLE
    end

Access your enumerated values using symbols.

    u = User.new
    u.role = :admin
    puts u.role_value

    # throws exception
    u.role = :unknown_role

    puts User.where_role(:admin).count

## Installation

Add this line to your application's Gemfile:

    gem 'attr_enum_accessor'

And then execute:

    $ bundle

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
