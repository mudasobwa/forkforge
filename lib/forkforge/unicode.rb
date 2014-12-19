# encoding: utf-8

require 'forkforge/internal/code_point'
require 'forkforge/internal/unicode_data'
require 'forkforge/internal/special_casing'

module Forkforge
  class UnicodeException < Exception
  end

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

    # As an opposite to decomposition: composes symbols using given string and tag (when possible).
    # This function is not intended to be used directly. Normally one uses one of aliases:
    #   - circle
    #   - super
    #   - sub
    #   - wide
    #
    # NB This is not a composition as it is understood by Unicode.Org (love them.)
    def compose s, tag = :font, format = :full
      composed = s.codepoints.map { |cp|
        (result = Forkforge::UnicodeData::compose_cp(cp, tag)).vacant? ? [Forkforge::UnicodeData::to_codepoint(cp)] : result
      }

      raise UnicodeException, "AMBIGUITIES FOUND, FIXME FIXME FIXME" \
        if format == :lazy && (composed.length != s.length)

      case format
      when :full then Hash[s.split('').map.with_index { |ch, idx| [[ch,idx], composed[idx]] }]
      when :lazy then composed.join
      when :risk then composed.map(&:first).join
      else composed
      end
    end

    [:circle, :super, :sub, :wide].each { |m|
      define_method(m) { |s|
          compose decompose(s), m.to_sym, :lazy
      }
    }

    # Decomposes symbols to their combined representation, e.g. ASCII c-cedilla to 2 symbols
    def decompose s, tags = []
      s.codepoints.map { |cp|
        Forkforge::UnicodeData::decompose_cp cp, tags
      }.flatten.map { |cp| cp.to_i(16) }.pack('U*')
    end

    extend self
  end

end
