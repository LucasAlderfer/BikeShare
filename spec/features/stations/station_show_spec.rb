require 'rails_helper'

describe 'as a visitor' do
  context 'visits /station/:id' do
    it 'sees station show page' do
      station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')

      visit stations_path

      click_on station_1.name

      expect(current_path).to eq '/stations/hello'
      expect(page).to have_content station_1.name
      expect(page).to have_content station_1.city
      expect(page).to have_content station_1.dock_count
      expect(page).to have_content station_1.installation_date
    end
  end
end

describe 'as a user' do
  context 'visits /stations/:id' do
    it 'sees station show page' do
      user = User.create(username: "asdf", password: "asdf")
      
      station_1 = Station.create(name: 'hello', dock_count: 2, city:'Denver', installation_date:'8/7/2010')
      station_2 = Station.create(name: 'world', dock_count: 3, city:'Chicago', installation_date:'8/7/2010')

      trip_1 = Trip.create!(duration:8, start_date:'8/9/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 2, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/9/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/10/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/10/2010', start_station_id: 2, end_date: '8/11/2010', end_station_id: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_5 = Trip.create!(duration:8, start_date:'8/9/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 2, bike_id: 4, subscription_type: "Customer", zip_code: 22207)
      trip_6 = Trip.create!(duration:8, start_date:'8/12/2010', start_station_id: 1, end_date: '8/12/2010', end_station_id: 2, bike_id: 3, subscription_type: "Subscriber", zip_code: 22207)


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      # not completely sure this will work, might need to visit '/stations/hello'
      visit station_path(station_1.name)

      expect(current_path).to eq '/stations/hello'
      expect(page).to have_content("Number of rides started at this station: 3")
      expect(page).to have_content("Number of rides completed at this station: 3")
      expect(page).to have_content("Most frequent destination station from this station: #{station_2.name}")
      expect(page).to have_content("Most frequent origination station to this station: #{station_2.name}")
      expect(page).to have_content("Date with most starting trips: 8/8/2010")
      expect(page).to have_content("Most frequent customer zip code: 22207")
      expect(page).to have_content("Bike that started the most trips from this station: Bike 4")
    end
  end
end
