# -*- encoding: utf-8 -*-
# frozen_string_literal: true
module K
  module Replace
    module VERSION
      MAJOR = 0
      MINOR = 1
      PATCH = 0

      STRING = [MAJOR, MINOR, PATCH].compact.join('.')

      def self.version
        STRING
      end
    end
  end
end
