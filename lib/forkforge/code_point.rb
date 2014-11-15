# encoding: utf-8

module Forkforge
  class CodePoint
    UNICODE_FIELDS = [
      :code_point,
      :character_name,
      :general_category,
      :canonical_combining_classes,
      :bidirectional_category,
      :character_decomposition_mapping,
      :decimal_digit_value,
      :digit_value,
      :numeric_value,
      :mirrored,
      :unicode_1_0_name,
      :_10646_comment_field,
      :uppercase_mapping,
      :lowercase_mapping,
      :titlecase_mapping
    ]

    UNICODE_FIELDS.each { |f|
      class_eval %Q{
        attr_reader :#{f}
      }
    }
    def initialize hash
      UNICODE_FIELDS.each { |f|
        instance_eval %Q{
          @#{f} = hash[:#{f}]
        }
      }
    end
    def to_s
      [@code_point.to_i(16)].pack('U')
    end
    def inspect
      "#{to_s} ⇒ #{@character_name}"
    end
  end
end
