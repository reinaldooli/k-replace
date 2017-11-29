# -*- encoding: utf-8 -*-
# frozen_string_literal: true
require 'test_helper'

class KeysTest < Minitest::Test

  def test_that_returns_all_keys_in_text
    statement = K::Replace::Statement.new "Hello, I'm ##__User.name__##!"
    keys = statement.keys
    assert_equal 1, keys.size
    assert_equal keys, ['User.name']
  end

  def test_that_return_all_keys_in_text_with_many_keys
    statement = K::Replace::Statement.new "##__User.name__## <##__User.email__##>"
    keys = statement.keys
    assert_equal 2, keys.size
    assert_equal keys, ['User.name', 'User.email']
  end

  def test_that_return_keys_chained
    statement = K::Replace::Statement.new "Hello, I'm ##__User.name__##!"
    matches = statement.keys
    chained = statement.chain_property(matches.first)
    assert_equal({ user: "name" }, chained)
  end

  def test_that_return_all_keys_chained
    statement = K::Replace::Statement.new "##__User.name__## <##__User.email__##>"
    chained = statement.chain_properties(statement.source)
    assert_equal({ user: ["name", "email"] }, chained)
  end

  def test_tath_return_all_keys_chained_in_any_order
    statement = K::Replace::Statement.new "##__User.name__##, ##__User.address.street__## <##__User.email__##>"
    expected = { user: ["name", "email", address: "street"] }

    chained = statement.chain_properties(statement.source)

    assert_same_items(expected[:user], chained[:user])
  end
end
