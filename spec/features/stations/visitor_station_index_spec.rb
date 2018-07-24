require 'rails_helper'

describe ' as a visitor' do
  context 'visits /station' do
    it 'sees station index' do
      station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')
      station_2 = Station.create(name: 'goodbye', dock_count:3, city:'Boulder', installation_date:'8/8/2010')

      visit stations_path

      expect(page).to have_content "Name: #{station_1.name}"
      expect(page).to have_content "Name: #{station_2.name}"
      expect(page).to have_content "City: #{station_1.city}"
      expect(page).to have_content "Installation Date: #{station_1.installation_date}"
      expect(page).to have_content "Dock Count: #{station_1.dock_count}"
      expect(page).to have_content "City: #{station_2.city}"
      expect(page).to have_content "Installation Date: #{station_2.installation_date}"
      expect(page).to have_content "Dock Count: #{station_2.dock_count}"
    end
  end
end
