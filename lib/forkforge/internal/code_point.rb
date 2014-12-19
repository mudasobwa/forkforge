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
      "'#{to_s}' ⇒ [#{@character_name}]"
    end
  end

  class CodePoints
    def initialize hash
      @hash = hash
    end

    def filter field, pattern = nil
      pattern = case pattern
                when NilClass then /\A.+/ # not empty
                when Regexp   then pattern
                else Regexp.new(pattern)
                end
      @hash.select { |k, v|
        v[field.to_sym] =~ pattern
      }
    end
    private :filter

    def select field, pattern = nil
      CodePoints.new filter field, pattern
    end

    def inspect
      @hash.inspect
    end

    def to_a
      @hash.values
    end

    # FIXME is is shallow or deep copy?
    def to_h
      @hash.dup
    end

    def to_s
      @hash.values.map { |v|
        CodePoint.new(v).to_s
      }.join
    end

    def respond_to? method
      m = "#{method}".split '_'
      return !(filter :character_name, /#{m}/i).empty?
    end

    def method_missing method, *args, &block
      m, rest = "#{method}".split '_', 2
      if args.count <= 1 && !(result = filter :character_name, /#{m}/i).empty?
        result.select! { |k, v|
          v[:character_decomposition_mapping] =~ case args.first
            when String then /#{args.first.codepoints.map { |cp| '%04X' % cp }.join('|')}\Z/
            when Integer then /#{'%04X' % cp}/
            when Regexp then args.first
            else /#{args.first}/
            end
        } if args.count > 0
        result.each do |k, v|
          yield CodePoint.new v
        end if block_given? && !rest.nil?
        result = CodePoints.new(result)
        rest.nil? ? result : result.send(rest.to_sym)
      else
        super
      end
    end
  end
end
