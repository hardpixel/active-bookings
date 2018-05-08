require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record'

module ActiveBookings
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    desc 'Generates migrations to add Active Bookings table.'
    source_root File.expand_path('../templates', __FILE__)

    def create_migration_file
      migration_template 'migration/migration.rb', 'db/migrate/create_active_bookings.rb'
    end

    def create_model_file
      template 'model/booking.rb', 'app/models/booking.rb'
    end

    def self.next_migration_number(dirname)
      ::ActiveRecord::Generators::Base.next_migration_number(dirname)
    end
  end
end
