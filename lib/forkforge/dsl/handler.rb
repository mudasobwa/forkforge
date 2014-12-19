# encoding: utf-8

module Forkforge
  class Handler
    def initialize handler_class, *args
      @handler = handler_class.split('::').inject(Object) do |mod, clazz|
        mod.const_get(clazz)
      end.new *args

      @delayed = []
    end

    def method_missing method, *args, &block
      if @handler.respond_to? method
        @handler.send(method, *args, &block)
        @delayed.clear
      else
        @delayed.unshift "#{method}"
      end
    end

    def parse input
      self.instance_eval %Q{
        #{File.read input}
      }
    end
  end
end
