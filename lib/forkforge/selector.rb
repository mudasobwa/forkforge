# encoding: utf-8

require 'forkforge'
require 'awesome_print'

module Forkforge
  module Selector
    def self.included base
      re, basename = nil, base.name.gsub(/.*::/, '')
      # FILTER = { 'Tagged' => /^<.*?>$/ }
      if base.const_defined?(:FILTER)
        filter = base.const_get(:FILTER).to_a.flatten
        re = filter.last
        basename = basename.gsub(/^#{filter.first}/, '')
      end
      basename = (Forkforge::Unicode::camel_to_underscore basename).to_sym

      # HASH = Forkforge::UnicodeData::all_character_name /^<.*?>$/
      base.const_set :HASH, UnicodeData::send("all_#{basename}", re)

      # ALL = Forkforge::UnicodeData::all_bidirectional_category.uniq
      base.const_set :ALL, base::HASH.map { |k, v| v[basename] }.uniq

      base.class_eval %Q{
        CHARACTERS = HASH.reduce({}) { |memo, v|
          (memo[v.last[:#{basename}]] ||= []) << v.last
          memo
        }
      }

      base.extend base
    end
  end

  module TaggedCharacterName
    FILTER = { 'Tagged' => /^<.*?>$/ }

    include Selector

    # E. g. def control ⇒ [ ALL_ITEMS_WITH_CONTROL_NAME ]
    CHARACTERS.each { |k, v|
      tc = k.downcase.gsub(/^<|>$/, '').gsub(/\W/, '_')
      class_eval %Q{
        def #{tc}
          #{v}
        end
      }
    }
  end

  module BidirectionalCategory
    include Selector
  end

end
