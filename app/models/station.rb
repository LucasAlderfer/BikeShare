class Station < ApplicationRecord
  validates_presence_of :name, :city, :dock_count, :installation_date

  def self.stations_count
    count
  end

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

  has_many :trips_from, :class_name => "Trip", :foreign_key => 'start_station_id'
  has_many :trips_to, :class_name => "Trip", :foreign_key => 'end_station_id'

end
