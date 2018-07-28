require 'rails_helper'

describe 'Admin' do
  it 'visits new trip page' do
    admin = User.create!(username:'fred', password:'hello', role: 1)
    station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')
    station_2 = Station.create(name: 'asdf', dock_count:2, city:'Denver', installation_date:'8/7/2010')
    duration = 60
    bike_id = 3
    start_date = "8/7/2010"
    end_date = "8/7/2010"
    zip = 12345
    sub_type = "Subscriber"



    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_trip_path

    fill_in :trip_duration, with: duration
    fill_in :trip_bike_id, with: bike_id
    fill_in :trip_start_date, with: start_date
    fill_in :trip_end_date, with: end_date
    fill_in :trip_zip_code, with: zip
    select sub_type, from: :trip_subscription_type
    select station_1.name, from: :trip_start_station_id
    select station_2.name, from: :trip_end_station_id
    click_on("Create Trip")


    expect(current_path).to eq(trip_path(1)) # I can't think of a better way to reference this trip...
    expect(page).to have_content duration
    expect(page).to have_content start_date.to_date
    expect(page).to have_content station_1.name
    expect(page).to have_content end_date.to_date
    expect(page).to have_content station_2.name
    expect(page).to have_content bike_id
    expect(page).to have_content sub_type
    expect(page).to have_content zip

  end
end
