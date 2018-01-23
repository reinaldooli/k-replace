# -*- encoding: utf-8 -*-
# frozen_string_literal: true
module K
  module Replace
    module DynamicAccessors

      def create_accessors(attributes)
        @_dynamic_attributes = attributes.with_indifferent_access
        @_dynamic_attributes.each_with_index do |attribute, index|
          create_accessor attribute[0].to_s
        end
      end

      private

        def create_accessor(name)
          class_eval <<-RUBY, __FILE__, __LINE__ + 1
            def #{name}
              @_dynamic_attributes["#{name}"]
            end
          RUBY
        end

    end
  end
end
