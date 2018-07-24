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
      station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010', initial_bike_count:2)
      station_2 = Station.create(name: 'fred', dock_count:4, city:'Arvada', installation_date:'8/8/2010', initial_bike_count:3)
      station_3 = Station.create(name: 'wilma', dock_count:6, city:'Aurora', installation_date:'8/9/2010', initial_bike_count:7)
      station_4 = Station.create(name: 'bob', dock_count:8, city:'Golden', installation_date:'8/10/2010', initial_bike_count:9)

      expect(Station.count).to eq(4)
      expect(Station.avg_docks).to eq(5)
      expect(Station.max_bikes).to eq(station_4)
      expect(Station.min_bikes).to eq(station_1)
      expect(Station.youngest).to eq(station_1)
      expect(Station.oldest).to eq(station_4)
    end
  end
end
