# encoding: utf-8

unless NilClass.respond_to? :strip
  class NilClass
    def strip
      nil
    end
    def match *args
      false
    end
  end
end


class Object
  def vacant?
    self.nil? ||
    self.respond_to?(:strip) && self.strip.empty? ||
    self.respond_to?(:zero?) && self.zero? ||
    Array === self && (self  - [nil]).empty?
  end
end

unless Hash.respond_to? :take
  class Hash
    def take count, from = 0
      Hash[self.to_a[from..from+count]]
    end
  end
end

unless Array.respond_to? :to_h
  class Array
    def to_h
      i = 0
      self.inject({}) { |memo, e|
        raise TypeError.new("wrong element type #{e.class} at #{i} (expected array)") unless Array === e
        raise ArgumentError.new("wrong array length at #{i} (expected 2, was #{e.count})") unless e.count == 2

        i += 1
        memo[e.first] = e.last
        memo
      }
    end
  end
end
