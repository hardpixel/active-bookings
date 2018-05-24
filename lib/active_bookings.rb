require 'active_record'
require 'active_record/version'
require 'active_support/core_ext/module'
require 'ice_cube'

IceCube.compatibility = 12 # Drop compatibility for :start_date, avoiding a bunch of warnings caused by serialization

module ActiveBookings
  extend ActiveSupport::Autoload

  autoload :Serializer
  autoload :Bookable
  autoload :Booker
  autoload :Booking
  autoload :VERSION
  autoload :TimeUtils
  autoload :DBUtils

  autoload_under 'bookable' do
    autoload :Core
  end

  class InitializationError < StandardError
    def initialize model, message
      super "Error initializing active_bookings on #{model.to_s} - " + message
    end
  end

  class OptionsInvalid < StandardError
    def initialize model, message
      super "Error validating options for #{model.to_s} - " + message
    end
  end

  class AvailabilityError < StandardError
  end
end

ActiveSupport.on_load(:active_record) do
  extend ActiveBookings::Bookable
  include ActiveBookings::Booker
end
