module Skeleton
  module Attributes
    def attr_presence(*methods)
      Array(methods).each do |method|
        define_method("#{method}?") do
          !!self.public_send(method.to_s)
        end
      end
    end

    def attr_not_empty(*methods)
      Array(methods).each do |method|
        define_method("#{method}?") do
          !self.public_send(method.to_s).empty?
        end
      end
    end
  end
end
