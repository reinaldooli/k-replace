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

  def test_replace_key_to_nested_object_property
    statement = K::Replace::Statement.new 'I\'m ##__User.name__## and I live in ##__User.address.street__##'
    @user.name = 'John Doe'
    @user.address = Address.new('Telegraph Av, 123')

    replaced = statement.replace @user

    assert_equal replaced, 'I\'m John Doe and I live in Telegraph Av, 123'
  end

  def test_replace_key_to_deep_nested_object_property
    statement = K::Replace::Statement.new 'I\'m ##__User.name__## and I live in ##__User.address.street__## - ##__User.address.city.name__##'
    @user.name = 'John Doe'
    @address = Address.new('Telegraph Av, 123')
    @address.city = City.new('Miami')
    @user.address = @address

    replaced = statement.replace @user

    assert_equal replaced, 'I\'m John Doe and I live in Telegraph Av, 123 - Miami'
  end

  class User
    attr_accessor :name, :age, :address

    def initialize
      @address = Address.new
    end
  end

  class Address
    attr_accessor :street, :city

    def initialize(street = nil)
      @street = street
    end
  end

  class City
    attr_accessor :name

    def initialize(name)
      @name = name
    end
  end
end
