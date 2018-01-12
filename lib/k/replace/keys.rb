# -*- encoding: utf-8 -*-
# frozen_string_literal: true
module K
  module Replace
    module Keys
      def find_all(text)
        [].tap do |arr|
          text.scan(kreplace.key_pattern) do |match|
            yield match[0] if block_given?
            arr << match[0]
          end
        end.flatten.compact
      end

      def chain_properties(text)
        keys, obj = find_all(text), Hash.new
        obj.tap do |it|
          keys.each do |i|
            it.merge!(chain_property(i)) do |k, ov, nv|
              if ov.kind_of?(Array) && nv.kind_of?(Array)
                ov.concat(nv).uniq
              elsif ov.kind_of?(Array) && !nv.kind_of?(Array)
                ov.<<(nv).uniq
              else
                [ ov, nv ]
              end
            end
          end
        end
      end

      def chain_property(property)
        Hash.new.tap do |hash|
          hash.merge!(array_chain(property.split('.'))) do |k, ov, nv|
            if ov.kind_of?(Array) && nv.kind_of?(Array)
              ov.concat(nv).uniq
            else
              ov << nv if ov.kind_of?(Array)
            end
          end
        end
      end

      private

      def kreplace
        @kreplace ||= Replace.config
      end

      def array_chain(chains)
        return chains[0] if chains.size == 1
        chained = Hash.new
        chained.tap{|c| c["#{chains.shift}".downcase.to_sym] = array_chain(chains)}
      end
    end
  end
end

# { user: ["name", "email", address: ["street", "number"]] }
