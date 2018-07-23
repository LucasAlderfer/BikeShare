require 'rails_helper'

describe 'visitor sees station dashboard' do
  it 'sees all dashboard info' do
    station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010', initial_bike_count:2)
    station_2 = Station.create(name: 'fred', dock_count:4, city:'Arvada', installation_date:'8/8/2010', initial_bike_count:3)
    station_3 = Station.create(name: 'wilma', dock_count:6, city:'Aurora', installation_date:'8/9/2010', initial_bike_count:7)
    station_4 = Station.create(name: 'bob', dock_count:8, city:'Golden', installation_date:'8/10/2010', initial_bike_count:9)

    visit '/stations-dashboard'

    expect(page).to have_content("Total station count: 4")#total count of stations
    expect(page).to have_content("Average number of docks: 5")#avgnumber bikes per station
    expect(page).to have_content("Max number of Docks: #{station_4.dock_count} #{station_4.name}")#maxnumber bikes available, maxnumber bikes station
    expect(page).to have_content("Min number of Docks: #{station_1.dock_count} #{station_1.name}")#minnumber bikes available, minnumber bikes station
    expect(page).to have_content(station_4.name)#most recent station
    expect(page).to have_content(station_1.name)#oldest station
  end
end
