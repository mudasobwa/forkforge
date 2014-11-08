# encoding: utf-8

require_relative 'monkeypatches'

module Forkforge
  module UnicodeData
    LOCATION = 'data'
    UNICODE_DATA_FILE = 'UnicodeData.txt'
    UNICODE_DATA_VERSION = '5.1.0'
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
    
    def from_codepoint cp
      case cp
      when Integer then hash["%04X" % cp]
      when String  then hash["%04X" % cp.to_i(16)]
      else nil
      end
    end
    
    def yo cp, action
      yoyo = UnicodeData::from_codepoint(cp)[action]
      [yoyo.vacant? ? cp : yoyo.to_i(16)].pack('U')
    end
    private :yo
    
    UNICODE_FIELDS.each { |method|
      class_eval %Q{
        def #{method} cp
          yo cp, :#{method}
        end
        def all_#{method} pattern = nil
          hash.select { |k, v| pattern.nil? ? !v[:#{method}].vacant? : !pattern.match(v[:#{method}]).nil? }
        end
      }
    }

    extend self
  end
end
