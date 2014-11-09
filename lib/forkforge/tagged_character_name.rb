# encoding: utf-8

require_relative 'monkeypatches'
require_relative 'unicode_data'

module Forkforge
  module TaggedCharacterName
    ALL_TAGGED = Forkforge::UnicodeData::all_character_name /<.*?>/
    
    TAGGED_CHARACTERS_NAMES = ALL_TAGGED.map { |k, v| v[:character_name] }.uniq
    
    TAGGED_CHARACTERS = ALL_TAGGED.reduce({}) { |memo, v| 
      (memo[v.last[:character_name]] ||= []) << v.last
      memo  
    }
    
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