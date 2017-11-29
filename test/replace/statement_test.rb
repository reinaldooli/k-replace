# -*- encoding: utf-8 -*-
# frozen_string_literal: true
require 'test_helper'

class ChangesTest < Minitest::Test
  def setup
    @user = User.new
  end

  def test_check_statement_keys
    statement = K::Replace::Statement.new "Hello, ##__User.name__##!"
    assert_equal statement.keys.size, 1
  end

  def test_replace_key
    statement = K::Replace::Statement.new "Hello, ##__User.name__##!"
    @user.name = 'John Doe'

    replaced = statement.replace @user

    assert_equal replaced, "Hello, John Doe!"
  end

  def test_replace_multiple_keys
    statement = K::Replace::Statement.new 'I\'m ##__User.name__## and I\'m ##__User.age__## years old.'
    @user.name = 'John Doe'
    @user.age = 18

    replaced = statement.replace @user

    assert_equal replaced, 'I\'m John Doe and I\'m 18 years old.'
  end

  class User
    attr_accessor :name, :age, :address

    def initialize
      @address = Address.new
    end
  end

  class Address
    attr_accessor :street

    def initialize(street = nil)
      @street = street
    end
  end
end
