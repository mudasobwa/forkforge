# encoding: utf-8

require_relative 'monkeypatches'
require_relative 'character_decomposition_mapping'

module Forkforge
  module UnicodeData
    LOCATION = 'data'
    UNICODE_DATA_FILE = 'UnicodeData.txt'
    UNICODE_DATA_VERSION = '5.1.0'
    
    CODEPOINT_FIELDS = {
      :origin => :code_point, 
      :upcase => :uppercase_mapping,
      :downcase => :lowercase_mapping, 
      :titlecase => :titlecase_mapping
    }
      
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

    @@unicode_data = nil
    
    def hash
      @@unicode_data = raw.split(/\R/).map do |line|
        values = line.split ';'
        [
          values.first,
          UNICODE_FIELDS.map { |f|
            [ f, values.shift ]
          }.to_h
        ]
      end.to_h if @@unicode_data.nil?
      @@unicode_data
    end

    def raw
      if File.exist? "#{LOCATION}/#{UNICODE_DATA_FILE}"
        raw = File.read "#{LOCATION}/#{UNICODE_DATA_FILE}"
      else
        require 'net/http'
        Net::HTTP.start("www.unicode.org") do |http|
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
      Integer === cp ? "%04X" % cp : cp
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
    def to_char cp, action = :origin
      result = hash[normalize_cp cp][CODEPOINT_FIELDS[action]].to_s.to_i(16)
      [result.vacant? ? (Integer === cp ? cp : cp.to_s.to_i(16)) : result].pack('U')
    end
    
    UNICODE_FIELDS.each { |method|
      class_eval %Q{
        def get_#{method} cp
          hash[normalize_cp cp][:#{method}]
        end
        def all_#{method} pattern = nil
          pattern = Regexp.new(pattern) unless pattern.nil? || Regexp === pattern
          hash.select { |k, v| pattern.nil? ? !v[:#{method}].vacant? : !pattern.match(v[:#{method}]).nil? }
        end
      }
    }

    def decompose_cp cp
      normalized = normalize_cp cp
      return Forkforge::CharacterDecompositionMapping::VARIANTS_UC[normalized] \
        if Forkforge::CharacterDecompositionMapping::VARIANTS_UC[normalized] 
      mapping = hash[normalized][:character_decomposition_mapping]
      mapping.vacant? ? normalized : mapping.split(' ').map { |cp|  decompose_cp cp }
    end

    extend self
  end
end
