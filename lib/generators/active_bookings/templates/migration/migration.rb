class CreateActiveBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.references :bookable, polymorphic: true, index: { name: 'index_active_bookings_bookable' }
      t.references :booker, polymorphic: true, index: { name: 'index_active_bookings_booker' }
      t.column :amount, :integer
      t.column :schedule, :text
      t.column :time_start, :datetime
      t.column :time_end, :datetime
      t.column :time, :datetime

      t.timestamps
    end
  end
end
