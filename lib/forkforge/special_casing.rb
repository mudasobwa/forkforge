# encoding: utf-8

require_relative 'monkeypatches'

module Forkforge
  module SpecialCasing
    LOCATION = 'data'
    SPECIAL_CASING_FILE = 'SpecialCasing.txt'

    SPECIAL_CASING_FIELDS = [
      :code_point,
      :lowercase_mapping,
      :titlecase_mapping,
      :uppercase_mapping,
      :condition_list,
      :comment
    ]

    @@special_casing = nil

    def hash
      if @@special_casing.nil?
        @@special_casing = {}
        raw.split(/\R/).each do |line|
          # comment is always last, while the amount of fields is subject to change
          comment = line.scan(/(?<=#).*?$/).first.strip
          line.gsub!(/;\s*#.*$/, '') unless comment.nil?
          values = line.split ';'
          (@@special_casing[values.first.strip] ||= []) << \
            (SPECIAL_CASING_FIELDS.map { |f|
              [ f, values.shift.strip ]
            } + [[ :comment, comment ]]).to_h
        end
      end
      @@special_casing
    end
    private :hash

    def raw
      if File.exist? "#{LOCATION}/#{SPECIAL_CASING_FILE}"
        raw = File.read "#{LOCATION}/#{SPECIAL_CASING_FILE}"
      else
        require 'net/http'
        Net::HTTP.start('www.unicode.org') do |http|
          resp = http.get "/Public/UNIDATA/#{SPECIAL_CASING_FILE}"
          if !File.exist? LOCATION
            require 'fileutils'
            FileUtils.mkpath LOCATION
          end
          open("#{LOCATION}/#{SPECIAL_CASING_FILE}", "wb") do |file|
            raw = resp.body.gsub(/^\s*#.*?$/, '').gsub(/\R+/, "\n").gsub(/\A\R+/, '')
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

    # filter_code_point '00A0' | filter_uppercase_mapping 0xA0 | ...
    SPECIAL_CASING_FIELDS.each { |method|
      class_eval %Q{
        def filter_#{method}(cp, filters = [])
          return hash[ncp = normalize_cp(cp)].nil? ? \
            nil : [*hash[ncp]].select { |h|
                    filters.inject(true) { |memo, f|
                      memo &&= h[:#{method}].match f
                    }
                  } || [*hash[ncp]].select { |h| h[:#{method}].vacant? }
        end
        def all_#{method}(pattern = nil)
          pattern = Regexp.new(pattern) unless pattern.nil? || Regexp === pattern
          hash.map { |k, v|
            [
              k,
              v.reject { |vv|
                pattern.nil? ? vv[:#{method}].vacant? : pattern.match(vv[:#{method}]).nil?
              }
            ]
          }.to_h
        end
      }
    }

    [:uppercase, :lowercase, :titlecase].each { |method|
      class_eval %Q{
        def cp_#{method}(cp, lang = nil, context = nil)
          filters = []
          filters << Regexp.new('^' + lang + '(?=\\Z|\\s)') unless lang.nil?
          filters << Regexp.new('(?<=\\A|\\s)' + context + '$') unless context.nil?
          conditions = filter_condition_list cp, filters
          (conditions.vacant? || conditions.count != 1 || conditions.first[:#{method}_mapping].vacant? || conditions.first[:#{method}_mapping] == normalize_cp(cp)) ? \
            cp : conditions.first[:#{method}_mapping].split(' ').map { |cpn| cp_#{method}(cpn.to_i(16), lang, context) }
        end
        private :cp_#{method}
        def #{method}(cp, lang = nil, context = nil)
          (cpm = cp_#{method}(cp, lang, context)).nil? ? nil : [*cpm].pack('U')
        end
      }
    }

    extend self
  end
end
