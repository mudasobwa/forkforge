# encoding: utf-8

require 'forkforge/unicode'

class String

  def decompose tags = []
    Forkforge::Unicode::decompose self, tags
  end

  [:circle, :super, :sub, :wide].each { |m|
    class_eval %Q{
      def compose_#{m}
        Forkforge::Unicode::#{m} self
      end
    }
  }

  [:uppercase, :lowercase].each { |m|
    class_eval %Q{
      def #{m} lang = nil, context = nil
        Forkforge::Unicode::#{m} self, lang, context
      end
    }
  }

  alias_method :upcase, :uppercase
  alias_method :downcase, :lowercase

end
