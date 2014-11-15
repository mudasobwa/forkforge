# encoding: utf-8

require 'forkforge/version'
require 'forkforge/code_point'
require 'forkforge/unicode_data'
require 'forkforge/special_casing'

module Forkforge
  module Unicode
    [:uppercase, :lowercase, :titlecase].each { |method|
      class_eval %Q{
        def #{method}(s, lang = nil, context = nil)
          s.each_codepoint.map { |cp|
            pretendent = SpecialCasing::#{method}(cp, lang, context)
            (pretendent.codepoints.count == 1 && pretendent.codepoints.first == cp) ? \
             UnicodeData::to_char(cp, :#{method}_mapping) : pretendent
          }.join
        end
      }
    }

    def camel_to_underscore s, constant = false
      result = s.gsub(/(?<!\A)./) { |m|
        Letter::is_uppercase(m) ? "_#{m}" : m
      }
      constant ? uppercase(result) : lowercase(result)
    end

    def underscore_to_camel s
      (lowercase s).gsub(/((?<=\A)|_)(\w)/) {
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
