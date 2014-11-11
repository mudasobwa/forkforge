# encoding: utf-8

require_relative "unicode_data"

module Forkforge
  module Category
    # Letter::all_raw | Letter::uppercase_raw | Letter::uppercase 'Alexei' # ⇒ 'A'
    # Letter::uppercase_code_point | Mark::non_spacing_bidirectional_category
    def self.included base
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
  Mn  Mark, Non-Spacing
  Mc  Mark, Spacing Combining
  Me  Mark, Enclosing
=end
  module Mark
    TYPES = [
      ['M.', :all],
      ['Mn', :non_spacing],
      ['Mc', :spacing_combining],
      ['Me', :enclosing]
    ]
    include Forkforge::Category
  end

=begin
  Nd  Number, Decimal Digit
  Nl  Number, Letter
  No  Number, Other
=end
  module Number
    TYPES = [
      ['N.', :all],
      ['Nd', :decimal_digit],
      ['Nl', :letter],
      ['No', :other]
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

=begin
  Sm  Symbol, Math
  Sc  Symbol, Currency
  Sk  Symbol, Modifier
  So  Symbol, Other
=end
  module Symbol
    TYPES = [
      ['S.', :all],
      ['Sm', :math],
      ['Sc', :currency],
      ['Sk', :modifier],
      ['So', :other]
    ]
    include Forkforge::Category
  end

=begin
  Zs  Separator, Space
  Zl  Separator, Line
  Zp  Separator, Paragraph
=end
  module Separator
    TYPES = [
      ['Z.', :all],
      ['Zs', :space],
      ['Zl', :line],
      ['Zp', :paragraph]
    ]
    include Forkforge::Category
  end

=begin
  Cc  Other, Control
  Cf  Other, Format
  Cs  Other, Surrogate
  Co  Other, Private Use
  Cn  Other, Not Assigned (no characters in the file have this property)
=end
  module Other
    TYPES = [
      ['C.', :all],
      ['Cc', :control],
      ['Cf', :format],
      ['Cs', :surrogate],
      ['Co', :private_use],
      ['Cn', :not_assigned] # no characters in the file have this property
    ]
    include Forkforge::Category
  end

end
