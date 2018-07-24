class Station < ApplicationRecord
  validates_presence_of :name, :city, :dock_count, :installation_date

  has_many :trips_from, :class_name => "Trip", :foreign_key => 'start_station_id'
  has_many :trips_to, :class_name => "Trip", :foreign_key => 'end_station_id'
end
