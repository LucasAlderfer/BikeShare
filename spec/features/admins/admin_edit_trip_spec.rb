require 'rails_helper'

describe 'Admin' do
  describe 'can edit a trip' do
    station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')
    station_2 = Station.create(name: 'asdf', dock_count:2, city:'Denver', installation_date:'8/7/2010')
    admin = User.create!(username:'jorj', password:'hello', role: 1)

    trip_1 = Trip.create(duration: 34, start_station_id: 1, end_station_id: 1, bike_id: 3, start_date: '8/7/2010', end_date: '8/7/2010', subscription_type: 'Customer', zip_code: 12345)

    visit edit_admin_trip_path(trip_1)

    fill_in :duration, with: 60
    fill_in :bike_id, with: 4
    fill_in :start_date, with: "8/13/2012"
    fill_in :end_date, with: "8/14/2012"
    fill_in :zip_code, with: 54321
    select "Customer", from: :subscription_type
    select station_2.name, from: :start_station
    select station_1.name, from: :end_station
    click_on("Update Trip")

    expect(current_path).to eq(trip_path(trip_1))
    expect(trip_1.bike_id).to eq 4
    expect(trip_1.subscription_type).to eq("Customer")
    expect(trip_1.zip_code).to eq(54321)
    expect(page).to have_content("Subscription Type: Customer")
    expect(page).to have_content("Duration: 60")
  end
end
