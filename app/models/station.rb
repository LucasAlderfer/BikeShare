class Station < ApplicationRecord
  # removed initial_bike_count for seeding purposes - wasn't tested anyways (ANGRY GLARE!!!)
  validates_presence_of :name, :city, :dock_count, :installation_date

  def self.avg_docks
    average(:dock_count)
  end

  def self.max_bikes
    order('dock_count DESC').first
  end

  def self.min_bikes
    order(:dock_count).first
  end

  def self.youngest
    order(:installation_date).first
  end

  def self.oldest
    order('installation_date DESC').first
  end
end
