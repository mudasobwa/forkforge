# encoding: utf-8

require "forkforge/version"
require "forkforge/unicode_data"
require "forkforge/punctuation"

module Forkforge
  module Unicode
    def upcase s
      s.each_codepoint.map { |m|
        UnicodeData::to_char m, :upcase
      }.join
    end
    def downcase s
      s.each_codepoint.map { |m|
        UnicodeData::to_char m, :downcase
      }.join
    end
    # FIXME We are spitting on titlecase_mapping. Is this correct?
    def titlecase s
      s.split(/\b/).map { |s|
        s.strip.empty? ? s : upcase(s[0]) + downcase(s[1..-1])
      }.join
    end
    
    extend self
  end
end
