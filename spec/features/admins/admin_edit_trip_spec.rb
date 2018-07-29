require 'rails_helper'

describe 'Admin' do
  it 'can edit a trip' do
    station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')
    station_2 = Station.create(name: 'asdf', dock_count:2, city:'Denver', installation_date:'8/7/2010')
    admin = User.create!(username:'bob', password:'hello', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    trip_1 = Trip.create(duration: 34, start_station_id: 1, end_station_id: 1, bike_id: 3, start_date: '8/7/2010', end_date: '8/7/2010', subscription_type: 'Customer', zip_code: 12345)

    visit trip_path(trip_1)
    click_on "Edit"

    expect(current_path).to eq(edit_admin_trip_path(trip_1))

    fill_in :trip_duration, with: 60
    fill_in :trip_bike_id, with: 4
    fill_in :trip_start_date, with: "8/2/2012"
    fill_in :trip_end_date, with: "8/3/2012"
    fill_in :trip_zip_code, with: 54321
    select "Subscriber", from: :trip_subscription_type
    select station_2.name, from: :trip_start_station_id
    select station_1.name, from: :trip_end_station_id
    click_on("Update Trip")

    expect(current_path).to eq(trip_path(trip_1))
    expect(page).to have_content(60)
    expect(page).to have_content(4)
    expect(page).to have_content('8/2/2012'.to_date)
    expect(page).to have_content('8/3/2012'.to_date)
    expect(page).to have_content(54321)
    expect(page).to have_content('Subscriber')
    expect(page).to have_content("Starting station: #{station_2.name}")
    expect(page).to have_content("Ending station: #{station_1.name}")
  end
end
