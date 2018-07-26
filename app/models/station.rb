class Station < ApplicationRecord
  validates_presence_of :name, :city, :dock_count, :installation_date


  has_many :trips_from, :class_name => "Trip", :foreign_key => 'start_station_id'
  has_many :trips_to, :class_name => "Trip", :foreign_key => 'end_station_id'

  before_save :generate_slug


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

  def total_trips_from
    trips_from.count
  end

  def total_trips_to
    trips_to.count
  end


  def self.most_trips_to
    select('stations.*, count(trips.end_station_id) AS station_count')
          .joins(:trips_to)
          .group(:id)
          .order('station_count desc').first
  end

  def self.most_trips_from
    select('stations.*, count(trips.start_station_id) AS station_count')
          .joins(:trips_from)
          .group(:id)
          .order('station_count desc').first
  end

  def max_trips_date
    # trips_from.group(:start_date).count.max_by{|k, v| v}[0]
    max = trips_from.group(:start_date).count.values.max
    trips_from.group(:start_date).count.key(max)
  end

  def most_common_zip
    # trips_from.group(:start_date).count.max_by{|k, v| v}[0]
    max = trips_from.group(:zip_code).count.values.max
    trips_from.group(:zip_code).count.key(max)
  end

  def most_frequent_bike
    # trips_from.group(:start_date).count.max_by{|k, v| v}[0]
    max = trips_from.group(:bike_id).count.values.max
    trips_from.group(:bike_id).count.key(max)
  end

  private

  def generate_slug
    self.slug = name.parameterize
  end
end
