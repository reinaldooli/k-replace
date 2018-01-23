# -*- encoding: utf-8 -*-
# frozen_string_literal: true
module K
  module Replace
    class Statement
      include Keys
      include DynamicAccessors

      attr_reader :source, :keys

      def initialize(source)
        @keys = []
        @source = source

        find_all(@source) do |key|
          @keys << key
        end
      end

      def replace(hash)
        @source.gsub(kreplace.key_pattern) do |key|
          replaced = ''
          find_all(key) do |match|
            chained = chain_property(match)
            chained.each{|k, v| replaced = resolve_property(k, v, hash[k])}
          end
          replaced
        end
      end

      private

      def resolve_property(ch_key, ch_value, obj)
        return resolve_property ch_value.keys[0], ch_value[ch_value.keys[0]], obj.send(ch_value.keys[0].to_s) if ch_value.is_a?(Hash)
        obj.send(ch_value)
      end
    end
  end
end
