# -*- encoding: utf-8 -*-
# frozen_string_literal: true
module K
  module Replace
    module VERSION
      MAJOR = 1
      MINOR = 0
      PATCH = 0

      STRING = [MAJOR, MINOR, PATCH].compact.join('.')

      def self.version
        STRING
      end
    end
  end
end
