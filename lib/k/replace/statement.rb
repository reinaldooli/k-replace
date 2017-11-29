# -*- encoding: utf-8 -*-
# frozen_string_literal: true
module K
  module Replace
    class Statement
      include Keys
      include Changes

      attr_reader :source, :keys


      def initialize(source)
        @keys = []
        @source = source

        find_all(@source) do |key|
          @keys << key
        end
      end

      def replace(*objects)
        objs = hash_objects(objects)
        @source.gsub(kreplace.key_pattern) do |key|
          replaced = ''
          find_all(key) do |match|
            chained = chain_property(match)
            chained.each{|k, v| replaced = objs[k].send(v)}
          end
          replaced
        end
      end
    end
  end
end
