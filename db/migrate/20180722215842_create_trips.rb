class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.integer :duration, :limit => 8
      t.datetime :start_date
      t.string :start_station
      t.datetime :end_date
      t.string :end_station
      t.integer :bike_id, :limit => 8
      t.string :subscription_type
      t.integer :zip_code, :limit => 8
    end
  end
end
