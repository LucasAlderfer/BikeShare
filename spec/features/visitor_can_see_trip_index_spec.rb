require 'rails_helper'

describe 'as a visitor' do
  context 'visits /trips' do
    it 'sees trip index' do
      trip_1 = Trip.create!(duration:8, start_date:'8/8/2010', start_station: 'hello', end_date: '8/9/2010', end_station: 'goodbye', bike_id: 4, subscription_type: 3, zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/9/2010', start_station: 'uhb', end_date: '8/10/2010', end_station: 'gdjkd', bike_id: 5, subscription_type: 2, zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/10/2010', start_station: 'kjhbdf', end_date: '8/11/2010', end_station: 'kuygd', bike_id: 6, subscription_type: 1, zip_code: 22201)

      visit trips_path

      expect(page).to have_content trip_1.duration
      expect(page).to have_content trip_1.start_date
      expect(page).to have_content trip_1.start_station
      expect(page).to have_content trip_1.end_date
      expect(page).to have_content trip_1.end_station
      expect(page).to have_content trip_1.bike_id
      expect(page).to have_content trip_1.subscription_type
      expect(page).to have_content trip_1.zip_code
      expect(page).to have_content trip_2.duration
      expect(page).to have_content trip_2.start_date
      expect(page).to have_content trip_2.start_station
      expect(page).to have_content trip_2.end_date
      expect(page).to have_content trip_2.end_station
      expect(page).to have_content trip_2.bike_id
      expect(page).to have_content trip_2.subscription_type
      expect(page).to have_content trip_2.zip_code
      expect(page).to have_content trip_3.duration
      expect(page).to have_content trip_3.start_date
      expect(page).to have_content trip_3.start_station
      expect(page).to have_content trip_3.end_date
      expect(page).to have_content trip_3.end_station
      expect(page).to have_content trip_3.bike_id
      expect(page).to have_content trip_3.subscription_type
      expect(page).to have_content trip_3.zip_code
    end
  end
end
