require 'rails_helper'

context 'as an admin' do
  describe 'visiting stations/show' do
    it 'can see edit and delete buttons for that station' do
      station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')
      admin = User.create!(username:'dhdf', password:'hello', role: 1)
      trip_1 = Trip.create!(duration:8, start_date:'8/9/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 1, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/9/2010', start_station_id: 1, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit station_path(station_1.name)

      expect(page).to have_content station_1.name
      expect(page).to have_content station_1.city
      expect(page).to have_content station_1.dock_count
      expect(page).to have_content station_1.installation_date
      expect(page).to have_button 'Edit'
      expect(page).to have_button 'Delete'
    end
  end

  describe 'visiting stations/index' do
    it 'can see edit and delete buttons for each station' do
      station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')
      station_2 = Station.create(name: 'goodbye', dock_count:3, city:'Boulder', installation_date:'8/8/2010')
      admin = User.create!(username:'dhdf', password:'hello', role: 1)
      trip_1 = Trip.create!(duration:8, start_date:'8/9/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 2, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/9/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit stations_path

      within "#station-#{station_1.id}" do
        expect(page).to have_content "#{station_1.name}"
        expect(page).to have_content "#{station_1.city}"
        expect(page).to have_content "#{station_1.installation_date}"
        expect(page).to have_content "#{station_1.dock_count}"
        expect(page).to have_button 'Edit'
        expect(page).to have_button 'Delete'
      end

      within "#station-#{station_2.id}" do
        expect(page).to have_content "#{station_2.name}"
        expect(page).to have_content "#{station_2.city}"
        expect(page).to have_content "#{station_2.installation_date}"
        expect(page).to have_content "#{station_2.dock_count}"
        expect(page).to have_button 'Edit'
        expect(page).to have_button 'Delete'
      end
    end
  end

  describe 'visiting stations/show' do
    it 'can create a new station' do
      admin = User.create!(username:'dhdf', password:'hello', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_station_path

      station = Station.new(name: "hello", dock_count: 2, city: "Denver", installation_date: "8/7/2010")

      trip_1 = Trip.create(duration: 45, zip_code: 12345, start_station_id: 1, end_station_id: 1, start_date: "8/7/2010", end_date: "8/8/2010", bike_id: 123, subscription_type: "asdf")

      fill_in :station_name, with: station.name
      fill_in :station_dock_count, with: station.dock_count
      fill_in :station_city, with: station.city
      fill_in :station_installation_date, with: "8/7/2010"

      click_on "Create Station"

      expect(page).to have_content "Station Name: hello"
      expect(page).to have_content "Dock Count: 2"
      expect(page).to have_content "City: Denver"
      expect(page).to have_content "Installation Date: 2010-08-07"
      expect(page).to have_content "You have successfully created hello station"
    end
    it 'cannot create an invalid station' do
      admin = User.create!(username:'dhdf', password:'hello', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_station_path

      station = Station.new(name: "hello", dock_count: 2, city: "Denver", installation_date: "8/7/2010")

      trip_1 = Trip.create(duration: 45, zip_code: 12345, start_station_id: 1, end_station_id: 1, start_date: "8/7/2010", end_date: "8/8/2010", bike_id: 123, subscription_type: "asdf")

      fill_in :station_name, with: station.name

      click_on "Create Station"

      expect(page).to have_content("Station was not properly created")
    end
  end
  describe 'visiting stations/edit' do
    it 'can edit a station' do
      admin = User.create!(username:'dhdf', password:'hello', role: 1)
      station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit edit_admin_station_path(station_1.name)

      fill_in :station_name, with: 'goodbye'
      fill_in :station_dock_count, with: 3
      fill_in :station_city, with: 'Kansas'
      fill_in :station_installation_date, with: '6/9/2018'

      click_on "Update Station"

      expect(current_path).to eq station_path('goodbye')
      expect(page).to have_content "goodbye"
      expect(page).to have_content "3"
      expect(page).to have_content "Kansas"
      expect(page).to have_content "2018-09-06"
      expect(page).to have_content "You have successfully updated goodbye station"
    end
    it 'cannot edit a station with invalid data' do
      admin = User.create!(username:'dhdf', password:'hello', role: 1)
      station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit edit_admin_station_path(station_1.name)

      fill_in :station_name, with: 'goodbye'
      fill_in :station_dock_count, with: 3
      fill_in :station_city, with: 'Kansas'
      fill_in :station_installation_date, with: 'not a date'

      click_on "Update Station"

      expect(page).to have_content("Station was not properly updated")
    end
  end
  describe 'visiting stations/index' do
    it 'can delete a station' do
      station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')
      station_2 = Station.create(name: 'goodbye', dock_count:3, city:'Boulder', installation_date:'8/8/2010')
      admin = User.create!(username:'dhdf', password:'hello', role: 1)
      trip_1 = Trip.create!(duration:8, start_date:'8/9/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 2, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/9/2010', start_station_id: 2, end_date: '8/10/2010', end_station_id: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit stations_path

      within "#station-#{station_1.id}" do
        click_button 'Delete'
      end

      expect(current_path).to eq stations_path
      expect(page).to have_content "#{station_2.name}"
      expect(page).to_not have_content "#{station_1.city}" # a flash message appears showing the name of the station, even though it was deleted
      expect(page).to have_content "You have successfully deleted #{station_1.name} station"
    end
  end
end
