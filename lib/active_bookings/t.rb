module ActiveBookings
  module T
    def self.t(message, opts={})
      I18n.t('.active_bookings.' + message, opts)
    end

    def self.er(message, opts={})
      self.t('errors.messages.' + message, opts)
    end
  end
end
