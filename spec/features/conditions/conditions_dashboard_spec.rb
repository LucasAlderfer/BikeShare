require 'rails_helper'

describe 'User' do
  it 'visits the conditions dashboard' do
    user = User.create(username: "asdf", password: "asdf")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    condition_1 = Condition.create(cond_date: '8/9/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
    condition_2 = Condition.create(cond_date: '8/10/2010', max_temperature: 86, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 2, mean_wind_speed: 6, precipitation: 0.6)
    condition_3 = Condition.create(cond_date: '8/11/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
    condition_4 = Condition.create(cond_date: '8/12/2010', max_temperature: 86, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 2, mean_wind_speed: 6, precipitation: 0.6)

    station_1 = Station.create(name: 'hello', dock_count: 2, city:'Denver', installation_date:'8/7/2010')
    station_2 = Station.create(name: 'world', dock_count: 3, city:'Chicago', installation_date:'8/7/2010')

    trip_1 = Trip.create!(duration:8, start_date:'8/9/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 2, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
    trip_2 = Trip.create!(duration:8, start_date:'8/9/2010', start_station_id: 1, end_date: '8/9/2010', end_station_id: 2, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
    trip_3 = Trip.create!(duration:8, start_date:'8/10/2010', start_station_id: 1, end_date: '8/10/2010', end_station_id: 2, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
    trip_4 = Trip.create!(duration:8, start_date:'8/11/2010', start_station_id: 1, end_date: '8/11/2010', end_station_id: 2, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
    trip_5 = Trip.create!(duration:8, start_date:'8/12/2010', start_station_id: 1, end_date: '8/12/2010', end_station_id: 2, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
    trip_6 = Trip.create!(duration:8, start_date:'8/12/2010', start_station_id: 1, end_date: '8/12/2010', end_station_id: 2, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)


    visit conditions_dashboard_path

    expect(current_path).to eq(conditions_dashboard_path)

    expect(page).to have_content("Highest number of rides during max temp of 90..99: 2")
    expect(page).to have_content("Average number of rides during max temp of 90..99: 1.5")
    expect(page).to have_content("Lowest number of rides during max temp of 90..99: 1")
    expect(page).to have_content("Highest number of rides during max temp of 80..89: 2")
    expect(page).to have_content("Average number of rides during max temp of 80..89: 1.5")
    expect(page).to have_content("Lowest number of rides during max temp of 80..89: 1")
    expect(page).to have_content("Highest number of rides during precipitation between 0..0.49: 2")
    expect(page).to have_content("Average number of rides during precipitation between 0..0.49: 1.5")
    expect(page).to have_content("Lowest number of rides during precipitation between 0..0.49: 1")
    expect(page).to have_content("Highest number of rides during precipitation between 0.5..0.99: 2")
    expect(page).to have_content("Average number of rides during precipitation between 0.5..0.99: 1.5")
    expect(page).to have_content("Lowest number of rides during precipitation between 0.5..0.99: 1")
    expect(page).to have_content("Highest number of rides during wind speed between 0..3.9 mph: 2")
    expect(page).to have_content("Average number of rides during wind speed between 0..3.9 mph: 1.5")
    expect(page).to have_content("Lowest number of rides during wind speed between 0..3.9 mph: 1")
    expect(page).to have_content("Highest number of rides during wind speed between 4..7.9 mph: 2")
    expect(page).to have_content("Average number of rides during wind speed between 4..7.9 mph: 1.5")
    expect(page).to have_content("Lowest number of rides during wind speed between 4..7.9 mph: 1")
    expect(page).to have_content("Highest number of rides during mean visibility 0..3.9: 2")
    expect(page).to have_content("Average number of rides during mean visibility 0..3.9: 1.5")
    expect(page).to have_content("Lowest number of rides during mean visibility 0..3.9: 1")
    expect(page).to have_content("Highest number of rides during mean visibility 4..7.9: 2")
    expect(page).to have_content("Average number of rides during mean visibility 4..7.9: 1.5")
    expect(page).to have_content("Lowest number of rides during mean visibility 4..7.9: 1")
  end
end
