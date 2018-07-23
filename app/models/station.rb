class Station < ApplicationRecord
  # removed initial_bike_count for seeding purposes - wasn't tested anyways (ANGRY GLARE!!!)
  validates_presence_of :name, :city, :dock_count, :installation_date
end
