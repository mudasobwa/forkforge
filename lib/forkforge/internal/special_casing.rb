# encoding: utf-8

require 'forkforge/internal/monkeypatches'

module Forkforge
  module SpecialCasing
    include UnicodeOrgFileFormat

    LOCAL = 'data'
    REMOTE = 'Public/UNIDATA'
    FILE = 'SpecialCasing.txt'

    SPECIAL_CASING_FIELDS = [
      :code_point,
      :lowercase_mapping,
      :titlecase_mapping,
      :uppercase_mapping,
      :condition_list,
      :comment
    ]

    def hash
      i_hash REMOTE, LOCAL, FILE, SPECIAL_CASING_FIELDS
    end

    # filter_code_point '00A0' | filter_uppercase_mapping 0xA0 | ...
    SPECIAL_CASING_FIELDS.each { |method|
      define_method("filter_#{method}") { |cp, filters = []|
          return hash[ncp = __to_code_point(cp)].nil? ? \
            nil : [*hash[ncp]].select { |h|
                    filters.inject(true) { |memo, f|
                      memo &&= h[method.to_sym].match f
                    }
                  } || [*hash[ncp]].select { |h| h[method.to_sym].vacant? }
      }

      define_method("all_#{method}") { |pattern = nil|
        pattern = Regexp.new(pattern) unless pattern.nil? || Regexp === pattern
        hash.map { |k, v|
          [
            k,
            v.reject { |vv|
              pattern.nil? ? vv[method.to_sym].vacant? : pattern.match(vv[method.to_sym]).nil?
            }
          ]
        }.to_h
      }
    }

    [:uppercase, :lowercase, :titlecase].each { |method|
      class_eval %Q{
        def cp_#{method}(cp, lang = nil, context = nil)
          filters = []
          filters << Regexp.new('^' + lang + '(?=\\Z|\\s)') unless lang.nil?
          filters << Regexp.new('(?<=\\A|\\s)' + context + '$') unless context.nil?
          conditions = filter_condition_list cp, filters
          (conditions.vacant? || conditions.count != 1 || conditions.first[:#{method}_mapping].vacant? || conditions.first[:#{method}_mapping] == __to_code_point(cp)) ? \
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
