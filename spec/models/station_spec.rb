require 'rails_helper'

describe Station do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:dock_count)}
    it {should validate_presence_of(:installation_date)}
  end

  describe 'class methods' do
    it 'has several class methods' do
      station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')
      station_2 = Station.create(name: 'fred', dock_count:4, city:'Arvada', installation_date:'8/8/2010')
      station_3 = Station.create(name: 'wilma', dock_count:6, city:'Aurora', installation_date:'8/9/2010')
      station_4 = Station.create(name: 'bob', dock_count:8, city:'Golden', installation_date:'8/10/2010')

      expect(Station.stations_count).to eq(4)
      expect(Station.avg_docks).to eq(5)
      expect(Station.max_bikes).to eq(station_4)
      expect(Station.min_bikes).to eq(station_1)
      expect(Station.youngest).to eq(station_1)
      expect(Station.oldest).to eq(station_4)
    end
  end
  describe 'relationships' do
    it {should respond_to(:trips_from)}
    it {should respond_to(:trips_to)}
  end
  describe 'instance methods' do
    it 'tests all station instance methods' do
      station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')
      station_2 = Station.create(name: 'fred', dock_count:4, city:'Arvada', installation_date:'8/8/2010')
      station_3 = Station.create(name: 'wilma', dock_count:4, city:'Marvada', installation_date:'8/6/2010')

      trip_1 = Trip.create!(duration:8, start_date:'8/9/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 2, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/9/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/10/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/10/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_5 = Trip.create!(duration:8, start_date:'8/12/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 2, bike_id: 4, subscription_type: "Customer", zip_code: 22601)
      trip_6 = Trip.create!(duration:8, start_date:'8/12/2010', start_station_id: 1, end_date: '8/12/2010', end_station_id: 2, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_7 = Trip.create!(duration:8, start_date:'8/12/2010', start_station_id: 1, end_date: '8/12/2010', end_station_id: 2, bike_id: 3, subscription_type: "Subscriber", zip_code: 22207)
      trip_8 = Trip.create!(duration:8, start_date:'8/12/2010', start_station_id: 1, end_date: '8/12/2010', end_station_id: 3, bike_id: 3, subscription_type: "Subscriber", zip_code: 22207)

      expect(station_1.total_trips_from).to eq(5)
      expect(station_1.total_trips_to).to eq(3)

      expect(station_1.most_trips_to).to eq(station_2.name) # I figure this will return the entire station object, thoughts?
      expect(station_2.most_trips_from).to eq(station_1.name) # I figure this will return the entire station object, thoughts?
      expect(station_1.max_trips_date).to eq(trip_7.start_date)
      expect(station_1.most_common_zip).to eq(22207)
      expect(station_1.most_frequent_bike).to eq(4)
    end
  end
end
