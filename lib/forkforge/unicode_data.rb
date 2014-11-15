# encoding: utf-8

require_relative 'monkeypatches'
require_relative 'code_point'
require_relative 'character_decomposition_mapping'

module Forkforge
  module UnicodeData
    LOCATION = 'data'
    UNICODE_DATA_FILE = 'UnicodeData.txt'
    UNICODE_DATA_VERSION = '5.1.0'

    @@unicode_data = nil

    def hash
      @@unicode_data = raw.split(/\R/).map do |line|
        values = line.split ';'
        [
          values.first,
          CodePoint::UNICODE_FIELDS.map { |f|
            [ f, values.shift ]
          }.to_h
        ]
      end.to_h if @@unicode_data.nil?
      @@unicode_data
    end
    private :hash

    def raw
      if File.exist? "#{LOCATION}/#{UNICODE_DATA_FILE}"
        raw = File.read "#{LOCATION}/#{UNICODE_DATA_FILE}"
      else
        require 'net/http'
        Net::HTTP.start('www.unicode.org') do |http|
          resp = http.get "/Public/#{UNICODE_DATA_VERSION}/ucd/#{UNICODE_DATA_FILE}"
          if !File.exist? LOCATION
            require 'fileutils'
            FileUtils.mkpath LOCATION
          end
          open("#{LOCATION}/#{UNICODE_DATA_FILE}", "wb") do |file|
            raw = resp.body
            file.write raw
          end
        end
      end
      raw
    end

    def normalize_cp cp
      Integer === cp ? '%04X' % cp : cp
    end
    private :normalize_cp

    def info s
      case s
      when String then s.each_codepoint.map { |cp| hash[normalize_cp cp] }
      when Integer then [hash[normalize_cp s]]
      else nil
      end
    end

    # TODO return true/false whether the normalization was done?
    def to_char cp, action = :code_point
      result = hash[normalize_cp cp][action].to_s.to_i(16)
      [result.vacant? ? (Integer === cp ? cp : cp.to_s.to_i(16)) : result].pack('U')
    end

    # get_code_point '00A0' | get_character_decomposition_mapping 0xA0 | ...
    # all_code_point /00[A-C]\d/ | get_character_decomposition_mapping /00A*/ | ...
    CodePoint::UNICODE_FIELDS.each { |method|
      class_eval %Q{
        def get_#{method} cp
          ncp = normalize_cp cp
          return hash[ncp] ? hash[ncp][:#{method}] : nil
        end
        def all_#{method} pattern = nil
          pattern = Regexp.new(pattern) unless pattern.nil? || Regexp === pattern
          hash.select { |k, v| pattern.nil? ? !v[:#{method}].vacant? : !pattern.match(v[:#{method}]).nil? }
        end
      }
    }

    def compose cp, tag = :font
      normalized = normalize_cp cp
      all_character_decomposition_mapping(/\A#{CharacterDecompositionMapping::Tag.tag(tag).tag}\s+#{normalized}\Z/)
    end

    def decompose_cp cp, tags = []
      normalized = normalize_cp cp
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
