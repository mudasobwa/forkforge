# encoding: utf-8

require_relative "unicode_data"

=begin
Pc  Punctuation, Connector
Pd  Punctuation, Dash
Ps  Punctuation, Open
Pe  Punctuation, Close
Pi  Punctuation, Initial quote (may behave like Ps or Pe depending on usage)
Pf  Punctuation, Final quote (may behave like Ps or Pe depending on usage)
Po  Punctuation, Other
=end

module Forkforge
  module Punctuation
    TYPES = [
      ['P.', :all],
      ['Pc', :connectors],
      ['Pd', :dashes],
      ['Ps', :opens],
      ['Pe', :closes],
      ['Pi', :initial_quotes], # (may behave like Ps or Pe depending on usage)
      ['Pf', :final_quotes], # (may behave like Ps or Pe depending on usage)
      ['Po', :others]
    ]

    TYPES.each { |type|
      class_eval %Q{
        def #{type.last} s = nil
          @@#{type.last} ||= Forkforge::UnicodeData::all_general_category /#{type.first}/
          @@#{type.last}_array ||= @@#{type.last}.map { |k, v| Forkforge::UnicodeData::code_point k } 
          s.respond_to?(:scan) ? s.scan(Regexp.new(@@#{type.last}_array.join '|')) : @@#{type.last}_array
        end
      }
    }
        
    extend self
  end
end