require 'rails_helper'

describe 'Admin' do
  describe 'visits trip index page' do
    xit 'sees edit and delete buttons next to each trip' do
      station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')
      station_2 = Station.create(name: 'asdf', dock_count:2, city:'Denver', installation_date:'8/7/2010')
      admin = User.create!(username:'bob', password:'hello', role: 1)

      trip_1 = Trip.create(duration: 34, start_station_id: 1, end_station_id: 1, bike_id: 3, start_date: '8/7/2010', end_date: '8/7/2010', subscription_type: 'Customer', zip_code: 12345)
      trip_2 = Trip.create(duration: 34, start_station_id: 1, end_station_id: 2, bike_id: 3, start_date: '8/7/2010', end_date: '8/7/2010', subscription_type: 'Subscriber', zip_code: 12345)
      trip_3 = Trip.create(duration: 34, start_station_id: 2, end_station_id: 1, bike_id: 3, start_date: '8/7/2010', end_date: '8/7/2010', subscription_type: 'Customer', zip_code: 12345)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit trips_path


      # probably not the best way to test this data shows on the page, but it's already tested for users, so it feels redundant
      expect(page).to have_content("#{trip_1.subscription_type}")
      expect(page).to have_content("#{trip_2.subscription_type}")
      expect(page).to have_content("#{trip_3.subscription_type}")

      within("#trip-#{trip_1.id}") do
        expect(page).to have_button("Edit")
        expect(page).to have_button("Delete")
      end
      within("#trip-#{trip_2.id}") do
        expect(page).to have_button("Edit")
        expect(page).to have_button("Delete")
      end
      within("#trip-#{trip_3.id}") do
        expect(page).to have_button("Edit")
        expect(page).to have_button("Delete")
      end
    end
  end
end
