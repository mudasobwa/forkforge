# encoding: utf-8

class Object
  def vacant?
    self.nil? || 
    self.respond_to?(:strip) && self.strip.empty? ||
    Array === self && (self  - [nil]).empty? 
  end
end

class Hash
  def take count, from = 0
    Hash[self.to_a[from..from+count]]
  end
end