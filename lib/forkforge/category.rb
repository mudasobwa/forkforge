# encoding: utf-8

require_relative "unicode_data"

module Forkforge
  module Category
    def self.included base
      puts "#{base} → #{base.const_get(:TYPES)}"
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
      }
      base.const_get(:TYPES).each { |type|
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
  
=begin
  Lu  Letter, Uppercase
  Ll  Letter, Lowercase
  Lt  Letter, Titlecase
  Lm  Letter, Modifier
  Lo  Letter, Other
=end  
  module Letter
    TYPES = [
      ['L.', :all],
      ['Lu', :uppercase],
      ['Ll', :lowercase],
      ['Lt', :titlecase],
      ['Lm', :modifier],
      ['Lo', :other]
    ]
    include Forkforge::Category
  end

=begin
Pc  Punctuation, Connector
Pd  Punctuation, Dash
Ps  Punctuation, Open
Pe  Punctuation, Close
Pi  Punctuation, Initial quote (may behave like Ps or Pe depending on usage)
Pf  Punctuation, Final quote (may behave like Ps or Pe depending on usage)
Po  Punctuation, Other
=end
  module Punctuation
    TYPES = [
      ['P.', :all],
      ['Pc', :connector],
      ['Pd', :dash],
      ['Ps', :open],
      ['Pe', :close],
      ['Pi', :initial_quote], # (may behave like Ps or Pe depending on usage)
      ['Pf', :final_quote], # (may behave like Ps or Pe depending on usage)
      ['Po', :other]
    ]
    include Forkforge::Category
  end
    
end