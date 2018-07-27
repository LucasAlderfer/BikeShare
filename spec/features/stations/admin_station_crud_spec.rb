require 'rails_helper'

context 'as an admin' do
  describe 'visiting stations/show' do
    it 'can see edit and delete buttons for that station' do
      station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')
      admin = User.create!(username:'dhdf', password:'hello', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit station_path(station_1.name)

      expect(page).to have_content station_1.name
      expect(page).to have_content station_1.city
      expect(page).to have_content station_1.dock_count
      expect(page).to have_content station_1.installation_date
      expect(page).to have_button 'Edit'
      expect(page).to have_button 'Delete'
    end
  end

  describe 'visiting stations/index' do
    xit 'can see edit and delete buttons for each station' do
      station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')
      station_2 = Station.create(name: 'goodbye', dock_count:3, city:'Boulder', installation_date:'8/8/2010')
      admin = User.create!(username:'dhdf', password:'hello', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit stations_path

      within "#station-#{station_1.id}" do
        expect(page).to have_content "Name: #{station_1.name}"
        expect(page).to have_content "City: #{station_1.city}"
        expect(page).to have_content "Installation Date: #{station_1.installation_date}"
        expect(page).to have_content "Dock Count: #{station_1.dock_count}"
        expect(page).to have_button 'Edit'
        expect(page).to have_button 'Delete'
      end

      within "#station-#{station_2.id}" do
        expect(page).to have_content "Name: #{station_2.name}"
        expect(page).to have_content "City: #{station_2.city}"
        expect(page).to have_content "Installation Date: #{station_2.installation_date}"
        expect(page).to have_content "Dock Count: #{station_2.dock_count}"
        expect(page).to have_button 'Edit'
        expect(page).to have_button 'Delete'
      end
    end
  end

  describe 'visiting stations/show' do
    xit 'can create a new station' do
      admin = User.create!(username:'dhdf', password:'hello', role: 1)
      # station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_station_new_path

      fill_in :station_name, with: 'hello'
      fill_in :station_dock_count, with: 2
      fill_in :station_city, with: 'Denver'
      fill_in :station_installation_date, with: '8/7/2010'

      click_on "Create Station"

      expect(page).to have_content "Station Name: hello"
      expect(page).to have_content "Dock Count: 2"
      expect(page).to have_content "City: Denver"
      expect(page).to have_content "Installation Date: 8/7/2010"
      expect(page).to have_content "You have successfully created hello station"
    end
  end
  describe 'visiting stations/edit' do
    xit 'can edit a station' do
      admin = User.create!(username:'dhdf', password:'hello', role: 1)
      station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_station_edit_path(station_1)

      fill_in :station_name, with: 'goodbye'
      fill_in :station_dock_count, with: 3
      fill_in :station_city, with: 'Kansas'
      fill_in :station_installation_date, with: '6/9/2018'

      click_on "Update Station"

      expect(current_path).to eq station_path(station_1)
      expect(page).to have_content "Station Name: #{station_1.name}"
      expect(page).to have_content "Dock Count: #{station_1.dock_count}"
      expect(page).to have_content "City: #{station_1.city}"
      expect(page).to have_content "Installation Date: #{station_1.installation_date}"
      expect(page).to have_content "You have successfully updated #{station_1.name} station"
    end
  end
  describe 'visiting stations/index' do
    xit 'can delete a station' do
      station_1 = Station.create(name: 'hello', dock_count:2, city:'Denver', installation_date:'8/7/2010')
      station_2 = Station.create(name: 'goodbye', dock_count:3, city:'Boulder', installation_date:'8/8/2010')
      admin = User.create!(username:'dhdf', password:'hello', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit stations_path

      within "#station-#{station_1.id}" do
        click_button 'Delete'
      end

      expect(current_path).to eq stations_path
      expect(page).to have_content "Station Name: #{station_2.name}"
      expect(page).to_not have_content "Station Name: #{station_1.name}"
      expect(page).to have_content "You have successfully deleted #{station_1.name} station"
    end
  end
end
