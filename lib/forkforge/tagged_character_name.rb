# encoding: utf-8

require_relative 'monkeypatches'
require_relative 'unicode_data'

module Forkforge
  module Selector
    def self.included base
      # base.const_set(Unicode::camel_to_underscore(base.name).to_sym, )
      base.const_get(:TYPES).each { |type|
        base.class_eval %Q{
          def #{type.last}_raw
            @@#{type.last} ||= Forkforge::UnicodeData::all_general_category /#{type.first}/
          end
          def #{type.last} s = nil
            @@#{type.last}_array ||= #{type.last}_raw.map { |k, v| Forkforge::UnicodeData::to_char k }
            s.respond_to?(:scan) ? s.scan(Regexp.new(@@#{type.last}_array.join '|')) : @@#{type.last}_array
          end
        }
        UnicodeData::UNICODE_FIELDS.each { |method|
          base.class_eval %Q{
            def #{type.last}_#{method}
              @@#{type.last}_#{method} ||= #{type.last}_raw.map { |k, v|
                [ Forkforge::UnicodeData::to_char(k), Forkforge::UnicodeData::get_#{method}(k) ]
              }.to_h
            end
          }
        }
      }
      base.extend base
    end
  end

  module TaggedCharacterName
    # All items with tagged character name
    TAGGED_CHARACTER_NAME_HASH = Forkforge::UnicodeData::all_character_name /^<.*?>$/

    # Unique character names
    ALL = TAGGED_CHARACTER_NAME_HASH.map { |k, v| v[:character_name] }.uniq

    # Hash character_name ⇒ [items]
    TAGGED_CHARACTERS = TAGGED_CHARACTER_NAME_HASH.reduce({}) { |memo, v|
      (memo[v.last[:character_name]] ||= []) << v.last
      memo
    }

    # E. g. def control ⇒ [ ALL_ITEMS_WITH_CONTROL_NAME ]
    TAGGED_CHARACTERS.each { |k, v|
      tc = k.downcase.gsub(/^<|>$/, '').gsub(/\W/, '_')
      class_eval %Q{
        def #{tc}
          #{v}
        end
      }
    }

    extend self
  end
end
