# encoding: utf-8

require_relative 'monkeypatches'
require_relative 'unicode_data'

module Forkforge
  module BidirectionalDirectory
    ALL = Forkforge::UnicodeData::all_bidirectional_category.uniq

    # Hash bidirectional_directory ⇒ [items]
    BIDIRECTIONAL_DIRECTORY_HASH = ALL_TAGGED.reduce({}) { |memo, v|
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
