# encoding: utf-8

require 'forkforge/internal/monkeypatches'
require 'forkforge/internal/unicode_org_file'
require 'forkforge/internal/code_point'
require 'forkforge/internal/character_decomposition_mapping'

module Forkforge
  module UnicodeData
    include UnicodeOrgFileFormat

    LOCAL = 'data'
    REMOTE = 'Public/UCD/latest/ucd'
    FILE = 'UnicodeData.txt'

    def hash
      i_hash(REMOTE, LOCAL, FILE, CodePoint::UNICODE_FIELDS, false)
    end

    def code_points
      CodePoints.new hash
    end

    def info cp
      cp = cp.codepoints.first if String === cp && cp.length == 1
      hash[__to_code_point(cp)]
    end

    def infos string
      string.codepoints.map { |cp| hash[__to_code_point(cp)] }
    end

    # TODO return true/false whether the normalization was done?
    def to_char cp, action = :code_point
      elem = hash[__to_code_point(cp)]
      __to_char(elem[action].vacant? ? elem[:code_point] : elem[action])
    end

    def to_codepoint cp
      Forkforge::CodePoint.new info cp
    end

    # get_code_point '00A0' | get_character_decomposition_mapping 0xA0 | ...
    # all_code_point /00[A-C]\d/ | get_character_decomposition_mapping /00A*/ | ...
    CodePoint::UNICODE_FIELDS.each { |method|
      define_method("get_#{method}") { |cp|
        ncp = __to_code_point cp
        return hash[ncp] ? hash[ncp][method.to_sym] : nil
      }
      define_method("all_#{method}") { |pattern = nil|
        pattern = Regexp.new(pattern) unless pattern.nil? || Regexp === pattern
        hash.select { |k, v|
          pattern.nil? ? !v[method.to_sym].vacant? : !pattern.match(v[method.to_sym]).nil?
        }
      }
    }

    def compose_cp cp, tag = :font
      all_character_decomposition_mapping(/\A#{CharacterDecompositionMapping::Tag.tag(tag).tag}\s+#{__to_code_point cp}\Z/).values.map { |uf|
        Forkforge::CodePoint.new(uf)
      }
    end

    def decompose_cp cp, tags = []
      normalized = __to_code_point cp
      mapping = get_character_decomposition_mapping cp
      return normalized if mapping.vacant?

      cps = mapping.split ' '

      return normalized if ![*tags].empty? && \
        cps.inject(false) { |memo, cp|
          memo || (CharacterDecompositionMapping::Tag::tag?(cp) && ![*tags].include?(CharacterDecompositionMapping::Tag::tag(cp).sym))
        }

      cps.reject { |cp|
        Forkforge::CharacterDecompositionMapping::Tag::tag? cp
      }.map { |cp| decompose_cp cp, tags }
    end

    extend self
  end
end
