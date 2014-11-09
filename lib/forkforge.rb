# encoding: utf-8

require "forkforge/version"
require "forkforge/unicode_data"
require "forkforge/tagged_character_name"
require "forkforge/category"

module Forkforge
  module Unicode
    def upcase s
      s.each_codepoint.map { |cp|
        UnicodeData::to_char cp, :upcase
      }.join
    end
    def downcase s
      s.each_codepoint.map { |cp|
        UnicodeData::to_char cp, :downcase
      }.join
    end
    # FIXME We are spitting on titlecase_mapping. Is this correct?
    def titlecase s
      s.split(/\b/).map { |w|
        w.strip.empty? ? w : upcase(w[0]) + downcase(w[1..-1])
      }.join
    end
    
    def symbols_by_name pattern
      Forkforge::UnicodeData::all_character_name(pattern).map { |k, v|
        Forkforge::UnicodeData::to_char k
      }
    end
    extend self
  end
end
