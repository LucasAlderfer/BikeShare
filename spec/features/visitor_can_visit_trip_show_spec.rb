require 'rails_helper'

describe 'as a visitor' do
  context 'visits /trips/:id' do
    it 'sees trip information' do
      trip_1 = Trip.create!(duration:8, start_date:'8/8/2010', start_station: 'hello', end_date: '8/9/2010', end_station: 'goodbye', bike_id: 4, subscription_type: 3, zip_code: 22207)

      visit trips_path

      click_on trip_1.start_date

      expect(current_path).to eq trip_show_path(trip_1)
      expect(page).to have_content trip_1.duration
      expect(page).to have_content trip_1.start_date
      expect(page).to have_content trip_1.start_station
      expect(page).to have_content trip_1.end_date
      expect(page).to have_content trip_1.end_station
      expect(page).to have_content trip_1.subscription_type
      expect(page).to have_content trip_1.zip_code
      expect(page).to have_content trip_1.bike_id
    end
  end
end
