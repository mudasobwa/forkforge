# encoding: utf-8

require 'forkforge/version'
require 'forkforge/unicode_data'
require 'forkforge/special_casing'

module Forkforge
  module Unicode
    def upcase s, lang = nil, context = nil
      s.each_codepoint.map { |cp|
        pretendent = SpecialCasing::uppercase(cp, lang, context)
        (pretendent.codepoints.count == 1 && pretendent.codepoints.first == cp) ? \
         UnicodeData::to_char(cp, :upcase) : pretendent
      }.join
    end
    def downcase s
      s.each_codepoint.map { |cp|
        UnicodeData::to_char cp, :downcase
      }.join
    end
    def titlecase s
      s.each_codepoint.map { |cp|
        UnicodeData::to_char(cp, :titlecase) || UnicodeData::to_char(cp, :upcase)
      }.join
    end

    def camel_to_underscore s, upcase = false
      result = s.gsub(/(?<!\A)./) { |m|
        Letter::is_uppercase(m) ? "_#{m}" : m
      }
      upcase ? upcase(result) : downcase(result)
    end

    def underscore_to_camel s
      (downcase s).gsub(/((?<=\A)|_)(\w)/) {
        titlecase $~[2]
      }
    end

    def lookup pattern
      Forkforge::UnicodeData::all_character_name(pattern).map { |k, v|
        Forkforge::UnicodeData::to_char k
      }
    end

    def decompose s, tags = []
      s.each_codepoint.map { |cp|
        Forkforge::UnicodeData::decompose_cp cp, tags
      }
    end

    extend self
  end
end

require 'forkforge/category'
require 'forkforge/selector'
