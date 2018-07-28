require 'rails_helper'

describe 'Admin' do
  describe 'visits a trip show page' do
    station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')
    station_2 = Station.create(name: 'asdf', dock_count:2, city:'Denver', installation_date:'8/7/2010')
    admin = User.create!(username:'jorj', password:'hello', role: 1)

    trip_1 = Trip.create(duration: 34, start_station_id: 1, end_station_id: 1, bike_id: 3, start_date: '8/7/2010', end_date: '8/7/2010', subscription_type: 'Customer', zip_code: 12345)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit trip_path(trip_1)

    #another redundant test
    expect(page).to have_content("Subscription type: #{trip_1.subscription_type}")
    expect(page).to have_button("Edit")
    expect(page).to have_button("Delete")
  end
end
