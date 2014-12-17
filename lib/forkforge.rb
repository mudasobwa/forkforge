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

    # FIXME CURRENTLY WORKS ONLY ON ASCII
    def compose s, tag = :font, format = :full
      composed = s.codepoints.map { |cp|
        Forkforge::UnicodeData::compose_cp cp, tag
      }
      raise ::Error.new("AMBIGUITIES FOUND, FIXME FIXME FIXME") if format == :lazy && (composed.flatten.length != s.length)

      case format
      when :full then Hash[s.split('').map.with_index { |ch, idx| [ch, composed[idx]] }]
      when :lazy, :risk then composed.map(&:first).join
      else composed
      end
    end

    [:circle, :super, :sub, :wide].each { |m|
      class_eval %Q{
        def #{m} s
          compose s, :#{m}, :risk
        end
      }
    }

    # Decomposes symbols to their combined representation, e.g. ASCII c-cedilla to 2 symbols
    def decompose s, tags = []
      s.codepoints.map { |cp|
        Forkforge::UnicodeData::decompose_cp cp, tags
      }.flatten.map { |ch| UnicodeData.to_char(ch) }.join
    end

    extend self
  end
end

require 'forkforge/category'
require 'forkforge/selector'
