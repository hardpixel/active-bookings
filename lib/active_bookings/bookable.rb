module ActiveBookings
  module Bookable

    def bookable?
      false
    end

    ##
    # Make a model bookable
    #
    # Example:
    #   class Room < ActiveRecord::Base
    #     is_bookable
    #   end
    def is_bookable(options={})
      bookable(options)
    end

    private

    # Make a model bookable
    def bookable(options)
      if bookable?
        self.booking_opts = options
      else
        class_attribute :booking_opts
        self.booking_opts = options

        class_eval do
          serialize :schedule, IceCube::Schedule

          has_many :bookings, as: :bookable, dependent: :destroy, class_name: '::ActiveBookings::Booking'

          validates_presence_of :schedule, if: :schedule_required?
          validates_presence_of :capacity, if: :capacity_required?
          validates_numericality_of :capacity, if: :capacity_required?, only_integer: true, greater_than_or_equal_to: 0

          def self.bookable?
            true
          end

          def schedule_required?
            self.rentable? && self.booking_opts && self.booking_opts && self.booking_opts[:time_type] != :none
          end

          def capacity_required?
            self.rentable? && self.booking_opts && self.booking_opts[:capacity_type] != :none
          end
        end
      end

      include Core
    end
  end
end