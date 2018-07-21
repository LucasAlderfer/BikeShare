require 'rails_helper'

describe 'as a visitor' do
  context 'visits /station/:id' do
    it 'sees station show page' do
      station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010', initial_bike_count:2)

      visit stations_path

      click_on station_1.name

      expect(current_path).to eq '/stations/hello'
      expect(page).to have_content station_1.name
      expect(page).to have_content station_1.city
      expect(page).to have_content station_1.dock_count
      expect(page).to have_content station_1.installation_date
    end
  end
end
