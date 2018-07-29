class Station < ApplicationRecord
  validates_presence_of :name, :city, :dock_count, :installation_date


  has_many :trips_from, :class_name => "Trip", :foreign_key => 'start_station_id'
  has_many :trips_to, :class_name => "Trip", :foreign_key => 'end_station_id'

  before_save :generate_slug


  def self.stations_count
    count
  end

  def self.avg_docks
    average(:dock_count).floor
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

  def total_trips_from
    trips_from.count
  end

  def total_trips_to
    trips_to.count
  end


  def most_trips_to
    unless trips_from.count == 0
      trips_from.select('trips.end_station_id, count(end_station_id) as count').joins(:end_station).group(:end_station_id).order('count desc').first.end_station.name
    else
      0
    end
  end

  def most_trips_from
    unless trips_from.count == 0
      trips_from.select('trips.end_station_id, count(end_station_id) as count').joins(:end_station).group(:end_station_id).order('count').first.end_station.name
    else
      0
    end
  end

  def max_trips_date
    unless trips_from.count == 0
      trips_from.select('trips.start_date, count(start_date) as count').group(:start_date).order('count desc').first.start_date
    else
      0
    end
  end

  def most_common_zip
    unless trips_from.count == 0
      trips_from.select('trips.zip_code, count(zip_code) as count').group(:zip_code).order('count desc').first.zip_code
    else
      0
    end
  end

  def most_frequent_bike
    unless trips_from.count == 0
      trips_from.select('trips.bike_id, count(bike_id) as count').group(:bike_id).order('count desc').first.bike_id
    else
      0
    end
  end

  private

  def generate_slug
    self.slug = name.parameterize
  end
end
