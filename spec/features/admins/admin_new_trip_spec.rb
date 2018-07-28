require 'rails_helper'

describe 'Admin' do
  describe 'visits new trip page' do
    admin = User.create!(username:'jorj', password:'hello', role: 1)
    station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')
    station_2 = Station.create(name: 'asdf', dock_count:2, city:'Denver', installation_date:'8/7/2010')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_trip_path

    fill_in :duration, with: 60
    fill_in :bike_id, with: 3
    fill_in :start_date, with: "8/7/2010"
    fill_in :end_date, with: "8/7/2010"
    fill_in :zip_code, with: 12345
    select "Subscriber", from: :subscription_type
    select station_1.name, from: :start_station
    select station_2.name, from: :end_station
    click_on("Create Trip")


    expect(current_path).to eq(trip_path(1)) # I can't think of a better way to reference this trip...
    expect(page).to have_content trip_1.duration
    expect(page).to have_content trip_1.start_date
    expect(page).to have_content trip_1.start_station.name
    expect(page).to have_content trip_1.end_date
    expect(page).to have_content trip_1.end_station.name
    expect(page).to have_content trip_1.bike_id
    expect(page).to have_content trip_1.subscription_type
    expect(page).to have_content trip_1.zip_code

  end
end
