require 'rails_helper'

describe 'Visiting the trips dashboard' do
  context 'as a registered user' do
    before(:each) do
      station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')
      station_2 = Station.create(name: 'goodbye', dock_count:3, city:'Boulder', installation_date:'8/8/2010')
    end
    it 'sees the average duration of a ride' do
      trip_1 = Trip.create!(duration:8, start_date:'8/8/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 1, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/9/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 2, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/10/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      condition_1 = Condition.create(cond_date: '8/8/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_2 = Condition.create(cond_date: '8/9/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_3 = Condition.create(cond_date: '8/10/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)

      avg_duration = Trip.average_duration

      visit trips_dashboard_path

      expect(page).to have_content("Average Duration: #{avg_duration}")
    end
    it 'sees the longest ride' do
      trip_1 = Trip.create!(duration:8, start_date:'8/8/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 1, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/9/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 2, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/10/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      condition_1 = Condition.create(cond_date: '8/8/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_2 = Condition.create(cond_date: '8/9/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_3 = Condition.create(cond_date: '8/10/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)

      longest_ride = Trip.longest_duration

      visit trips_dashboard_path

      expect(page).to have_content("Longest Ride: #{longest_ride}")
    end
    it 'sees the shortest ride' do
      trip_1 = Trip.create!(duration:8, start_date:'8/8/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 1, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/9/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 2, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/10/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      condition_1 = Condition.create(cond_date: '8/8/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_2 = Condition.create(cond_date: '8/9/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_3 = Condition.create(cond_date: '8/10/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)

      shortest_ride = Trip.shortest_duration

      visit trips_dashboard_path

      expect(page).to have_content("Shortest Ride: #{shortest_ride}")
    end
    it 'sees the Station with the most rides as a starting place' do
      trip_1 = Trip.create!(duration:8, start_date:'8/8/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 1, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/9/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 2, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/10/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/10/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      condition_1 = Condition.create(cond_date: '8/9/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_2 = Condition.create(cond_date: '8/8/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_3 = Condition.create(cond_date: '8/10/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)

      most_per_starting_place = Trip.station_start_max

      visit trips_dashboard_path

      expect(page).to have_content("Station Most Frequently Started At: #{most_per_starting_place}")
    end
    it 'sees the Station with the most rides as an ending place' do
      trip_1 = Trip.create!(duration:8, start_date:'8/8/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 1, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/9/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/10/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/10/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      condition_1 = Condition.create(cond_date: '8/8/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_2 = Condition.create(cond_date: '8/9/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_3 = Condition.create(cond_date: '8/10/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)

      most_per_ending_place = Trip.station_end_max

      visit trips_dashboard_path

      expect(page).to have_content("Station Most Frequently Ended At: #{most_per_ending_place}")
    end
    it 'sees Month by Month breakdown of number of rides with subtotals for each year' do
      trip_1 = Trip.create!(duration:8, start_date:'8/1/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 1, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/2/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/3/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/4/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_5 = Trip.create!(duration:8, start_date:'8/5/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 1, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_6 = Trip.create!(duration:9, start_date:'8/6/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_7 = Trip.create!(duration:10, start_date:'8/7/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_8 = Trip.create!(duration:5, start_date:'8/8/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_9 = Trip.create!(duration:8, start_date:'8/9/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 1, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_10 = Trip.create!(duration:9, start_date:'8/10/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_11 = Trip.create!(duration:10, start_date:'8/11/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_12 = Trip.create!(duration:5, start_date:'8/12/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_13 = Trip.create!(duration:8, start_date:'8/1/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 1, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      condition_1 = Condition.create(cond_date: '8/1/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_2 = Condition.create(cond_date: '8/4/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_3 = Condition.create(cond_date: '8/6/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_4 = Condition.create(cond_date: '8/2/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_5 = Condition.create(cond_date: '8/3/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_6 = Condition.create(cond_date: '8/5/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_7 = Condition.create(cond_date: '8/7/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_8 = Condition.create(cond_date: '8/8/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_9 = Condition.create(cond_date: '8/9/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_10 = Condition.create(cond_date: '8/10/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_11 = Condition.create(cond_date: '8/11/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_12 = Condition.create(cond_date: '8/12/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)

      visit trips_dashboard_path

      expect(page).to have_content("January 2010: 2")
      expect(page).to have_content("February 2010: 1")
      expect(page).to have_content("March 2010: 1")
      expect(page).to have_content("April 2010: 1")
      expect(page).to have_content("May 2010: 1")
      expect(page).to have_content("June 2010: 1")
      expect(page).to have_content("July 2010: 1")
      expect(page).to have_content("August 2010: 1")
      expect(page).to have_content("September 2010: 1")
      expect(page).to have_content("October 2010: 1")
      expect(page).to have_content("November 2010: 1")
      expect(page).to have_content("December 2010: 1")
      expect(page).to have_content("2010 Ride Total: 13")
    end
    it 'sees the Most ridden bike with total number of rides for that bike' do
      trip_1 = Trip.create!(duration:8, start_date:'8/1/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/1/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 7, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/1/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/4/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_5 = Trip.create!(duration:8, start_date:'8/6/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22207)
      trip_6 = Trip.create!(duration:9, start_date:'8/6/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 7, subscription_type: "Customer", zip_code: 22406)
      condition_1 = Condition.create(cond_date: '8/1/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_2 = Condition.create(cond_date: '8/4/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_3 = Condition.create(cond_date: '8/6/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)

      most_ridden_bike = Trip.bike_with_most_rides
      most_number_of_rides = Trip.most_rides_on_one_bike

      visit trips_dashboard_path

      expect(page).to have_content("Most Ridden Bike: #{most_ridden_bike}, #{most_number_of_rides} rides")
    end
    it 'sees the Least ridden bike with total number of rides for that bike' do
      trip_1 = Trip.create!(duration:8, start_date:'8/1/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/1/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/1/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/4/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_5 = Trip.create!(duration:8, start_date:'8/6/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22207)
      trip_6 = Trip.create!(duration:9, start_date:'8/6/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      condition_1 = Condition.create(cond_date: '8/1/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_2 = Condition.create(cond_date: '8/4/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_3 = Condition.create(cond_date: '8/6/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)

      least_ridden_bike = Trip.bike_with_least_rides
      least_number_of_rides = Trip.least_rides_on_one_bike

      visit trips_dashboard_path

      expect(page).to have_content("Least Ridden Bike: #{least_ridden_bike}, #{least_number_of_rides} rides")
    end
    it 'sees the User subscription type breakout with both count and percentage' do
      trip_1 = Trip.create!(duration:8, start_date:'8/1/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/1/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/1/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/4/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_5 = Trip.create!(duration:9, start_date:'8/6/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      condition_1 = Condition.create(cond_date: '8/1/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_2 = Condition.create(cond_date: '8/4/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_3 = Condition.create(cond_date: '8/6/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)

      subs_count = Trip.subscriber_count
      subs_percent = Trip.subscriber_percent
      cust_count = Trip.customer_count
      cust_percent = Trip.customer_percent

      visit trips_dashboard_path

      expect(page).to have_content("Subscriber Count: #{subs_count}")
      expect(page).to have_content("Subscriber Percentage: #{subs_percent}")
      expect(page).to have_content("Customer Count: #{cust_count}")
      expect(page).to have_content("Customer Percentage: #{cust_percent}")
    end
    it 'sees the Single date with the highest number of trips with a count of those trips' do
      trip_1 = Trip.create!(duration:8, start_date:'8/1/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/1/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/1/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/4/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_5 = Trip.create!(duration:9, start_date:'8/6/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      condition_1 = Condition.create(cond_date: '8/1/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_2 = Condition.create(cond_date: '8/4/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_3 = Condition.create(cond_date: '8/6/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)

      date_of_most_trips = Trip.date_with_most_trips

      count_of_most_trips_in_one_day = Trip.most_trips_in_one_day_count

      visit trips_dashboard_path

      expect(page).to have_content("Date With Largest Number of Trips: #{date_of_most_trips}")
      expect(page).to have_content("Count of Most Trips in One Day: #{count_of_most_trips_in_one_day}")
    end
    it 'sees the Single date with the lowest number of trips with a count of those trips' do
      trip_1 = Trip.create!(duration:8, start_date:'8/1/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/1/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/1/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/4/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_5 = Trip.create!(duration:9, start_date:'8/6/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      condition_1 = Condition.create(cond_date: '8/1/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_2 = Condition.create(cond_date: '8/4/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_3 = Condition.create(cond_date: '8/6/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)

      date_of_least_trips = Trip.date_with_least_trips

      count_of_least_trips_in_one_day = Trip.least_trips_in_one_day_count

      visit trips_dashboard_path

      expect(page).to have_content("Date With Lowest Number of Trips: #{date_of_least_trips}")
      expect(page).to have_content("Count of Least Trips in One Day: #{count_of_least_trips_in_one_day}")
    end
    it 'sees the weather on the date with the highest number of trips' do
      trip_1 = Trip.create!(duration:8, start_date:'8/1/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/1/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/1/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/4/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_5 = Trip.create!(duration:9, start_date:'8/6/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      condition_1 = Condition.create(cond_date: '8/1/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_2 = Condition.create(cond_date: '8/4/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_3 = Condition.create(cond_date: '8/6/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)

      visit trips_dashboard_path

      expect(page).to have_content("Weather on date with largest number of trips: High - #{condition_1.max_temperature} degrees, Mean - #{condition_1.mean_temperature} degrees, Min - #{condition_1.min_temperature} degrees, Humidity - #{condition_1.mean_humidity}, Visibility - #{condition_1.mean_visibility}, Wind Speed - #{condition_1.mean_wind_speed}, Precipitation - #{condition_1.precipitation}")
    end
    it 'sees the weather on the date with the lowest number of trips' do
      trip_1 = Trip.create!(duration:8, start_date:'8/1/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/1/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/1/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/1/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_5 = Trip.create!(duration:9, start_date:'8/6/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      condition_1 = Condition.create(cond_date: '8/6/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_2 = Condition.create(cond_date: '8/1/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)

      visit trips_dashboard_path

      expect(page).to have_content("Weather on date with fewest number of trips: High - #{condition_1.max_temperature} degrees, Mean - #{condition_1.mean_temperature} degrees, Min - #{condition_1.min_temperature} degrees, Humidity - #{condition_1.mean_humidity}, Visibility - #{condition_1.mean_visibility}, Wind Speed - #{condition_1.mean_wind_speed}, Precipitation - #{condition_1.precipitation}")
    end
  end
end
