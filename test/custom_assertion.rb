# -*- encoding: utf-8 -*-
# frozen_string_literal: true
require 'minitest/assertions'

module Minitest::Assertions
  #
  #  Fails unless +expected and +actual have the same items.
  #
  def assert_same_items(expected, actual)
    assert same_items(expected, actual),
      "Expected #{ expected.inspect } and #{ actual.inspect } to have the same items"
  end

  #
  #  Fails if +expected and +actual have the same items.
  #
  def refute_same_items(expected, actual)
    refute same_items(expected, actual),
    "Expected #{ expected.inspect } and #{ actual.inspect } would not have the same items"
  end

  private
  def same_items(expected, actual)
    actual.is_a?(Enumerable) && expected.is_a?(Enumerable) &&
    expected.count == actual.count && actual.all? { |e| expected.include?(e) }
  end
end
