module ActiveBookings
  module Serializer
    class << self
      def load(string)
        if string.present?
          IceCube::Schedule.from_yaml(string)
        end
      end

      def dump(object)
        if object.is_a? IceCube::Schedule
          object.to_yaml
        end
      end
    end
  end
end
