class Station < ApplicationRecord
  validates_presence_of :name, :city, :dock_count, :installation_date, :initial_bike_count
end
