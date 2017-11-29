# -*- encoding: utf-8 -*-
# frozen_string_literal: true
module K
  module Replace
    module Changes
      private

      def hash_objects(objs)
        Hash.new.tap do |hsh|
          objs.each{|obj| hsh[obj.class.name.to_s.gsub(/^.*::/, '').downcase.to_sym] = obj}
        end
      end

      def call_attribute(objs, attrs)
        attrs.each do |k, atts|
          atts.each do |att|
            raise NoMethodError, "undefined method `#{att}` for #{objs[k].inspect}" unless
              !objs[k].nil? && objs[k].respond_to?(att)
            return objs[k].send(att)
          end
        end
      end
    end
  end
end
