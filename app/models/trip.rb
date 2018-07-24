class Trip < ApplicationRecord
  validates_presence_of :duration,
                        :start_date,
                        :start_station,
                        :end_date,
                        :end_station,
                        :bike_id,
                        :subscription_type,
                        :zip_code

  def self.average_duration
    average(:duration)
  end

  def self.longest_duration
    maximum(:duration)
  end

  def self.shortest_duration
    minimum(:duration)
  end

  def self.station_start_max
  end

  def self.number_of_rides_per_month
    group("date_trunc('month', start_date)").order('count_all desc').count
  end

  def self.total_trips_per_year
    group("date_trunc('year', start_date)").order('count_all desc').count
  end

  def self.bike_with_most_rides
    group(:bike_id).count(:bike_id).max[0]
  end

  def self.bike_with_least_rides
    group(:bike_id).count(:bike_id).min[0]
  end

  def self.subscriber_count
    where(subscription_type:'Subscriber').count
  end

  def self.customer_count
    where(subscription_type:'Customer').count
  end

  def self.subscriber_percent
    (subscriber_count * 100.00)/all.count
  end

  def self.customer_percent
    (customer_count * 100.00)/all.count
  end

  def self.date_with_most_trips
    group("date_trunc('day', start_date)").order('count_all desc').count.first[0]
  end

  def self.most_trips_in_one_day_count
    group("date_trunc('day', start_date)").order('count_all desc').count.first[1]
  end

  def self.date_with_least_trips
    group("date_trunc('day', start_date)").order('count_all').count.first[0]
  end

  def self.least_trips_in_one_day_count
    group("date_trunc('day', start_date)").order('count_all').count.first[1]
  end
end
