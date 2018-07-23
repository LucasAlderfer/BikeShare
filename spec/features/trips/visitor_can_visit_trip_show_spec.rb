require 'rails_helper'

describe 'as a visitor' do
  context 'visits /trips/:id' do
    it 'sees trip information' do
      trip_1 = Trip.create!(duration:8, start_date:'8/8/2010 14:13', start_station: 2, end_date: '8/9/2010 14:13', end_station: 1, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)

      visit trip_path(trip_1)

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
