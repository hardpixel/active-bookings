module ActiveBookings
  module Booker
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      ##
      # Make a model a booker. This allows an instance of a model to claim ownership
      # of bookings.
      #
      # Example:
      #   class User < ActiveRecord::Base
      #     is_booker
      #   end
      def is_booker(opts={})
        class_eval do
          has_many :bookings, as: :booker, dependent: :destroy, class_name: '::ActiveBookings::Booking'
        end

        include ActiveBookings::Booker::InstanceMethods
        extend ActiveBookings::Booker::SingletonMethods
      end

      def booker?
        false
      end
    end

    module InstanceMethods
      ##
      # Book a bookable model
      #
      # @param bookable The resource that will be booked
      # @return The booking created
      # @raise ActiveBookings::OptionsInvalid if opts are not valid for given bookable
      # @raise ActiveBookings::AvailabilityError if the bookable is not available for given options
      # @raise ActiveRecord::RecordInvalid if trying to create an invalid booking
      #
      # Example:
      #   @user.book!(@room)
      def book!(bookable, opts={})
        # check availability
        bookable.check_availability!(opts) if bookable.class.bookable?

        # create the new booking
        booking_params = opts.merge({booker: self, bookable: bookable})
        booking = ActiveBookings::Booking.create!(booking_params)

        # reload the bookable to make changes available
        bookable.reload
        self.reload
        booking
      end

      def booker?
        self.class.booker?
      end
    end

    module SingletonMethods
      def booker?
        true
      end
    end
  end
end
