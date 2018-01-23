# -*- encoding: utf-8 -*-
# frozen_string_literal: true
module K
  module Replace
    require "k/replace/config"
    require "k/replace/version"
    require "k/replace/dynamic_accessors"
    require "k/replace/keys"
    require "k/replace/statement"

    def self.setup
      yield config
    end

    def self.config
      @config ||= Config.new
    end

    setup do |config|
      config.key_pattern = /##__(.*?)__##/i
    end
  end
end
