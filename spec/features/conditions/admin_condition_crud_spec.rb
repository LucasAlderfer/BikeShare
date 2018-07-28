require 'rails_helper'

describe 'as a admin' do
  describe 'visiting conditons/index' do
    it 'can see edit and delete buttons for each condition' do
      condition_1 = Condition.create(cond_date: '8/9/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_2 = Condition.create(cond_date: '8/10/2010', max_temperature: 86, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 2, mean_wind_speed: 6, precipitation: 0.6)
      admin = User.create!(username:'dhdf', password:'hello', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit conditions_path

      within "#condition-#{condition_1.id}" do
        expect(page).to have_content "Date: #{condition_1.cond_date}"
        expect(page).to have_content "Max Temperature: #{condition_1.max_temperature}"
        expect(page).to have_content "Mean Temperature: #{condition_1.mean_temperature}"
        expect(page).to have_content "Min Temperature: #{condition_1.min_temperature}"
        expect(page).to have_content "Mean Humidity: #{condition_1.mean_humidity}"
        expect(page).to have_content "Mean Visibility: #{condition_1.mean_visibility}"
        expect(page).to have_content "Mean Wind Speed: #{condition_1.mean_wind_speed}"
        expect(page).to have_content "Precipitation: #{condition_1.precipitation}"
        expect(page).to have_button 'Edit'
        expect(page).to have_button 'Delete'
      end

      within "#condition-#{condition_2.id}" do
        expect(page).to have_content "Date: #{condition_2.cond_date}"
        expect(page).to have_content "Max Temperature: #{condition_2.max_temperature}"
        expect(page).to have_content "Mean Temperature: #{condition_2.mean_temperature}"
        expect(page).to have_content "Min Temperature: #{condition_2.min_temperature}"
        expect(page).to have_content "Mean Humidity: #{condition_2.mean_humidity}"
        expect(page).to have_content "Mean Visibility: #{condition_2.mean_visibility}"
        expect(page).to have_content "Mean Wind Speed: #{condition_2.mean_wind_speed}"
        expect(page).to have_content "Precipitation: #{condition_2.precipitation}"
        expect(page).to have_button 'Edit'
        expect(page).to have_button 'Delete'
      end
    end
  end
  describe 'visiting conditions/show' do
    it 'can see edit and delete buttons for that condition' do
      condition_1 = Condition.create(cond_date: '8/9/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      admin = User.create!(username:'dhdf', password:'hello', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit condition_path(condition_1)

      expect(page).to have_content "Date: #{condition_1.cond_date}"
      expect(page).to have_content "Max Temperature: #{condition_1.max_temperature}"
      expect(page).to have_content "Mean Temperature: #{condition_1.mean_temperature}"
      expect(page).to have_content "Min Temperature: #{condition_1.min_temperature}"
      expect(page).to have_content "Mean Humidity: #{condition_1.mean_humidity}"
      expect(page).to have_content "Mean Visibility: #{condition_1.mean_visibility}"
      expect(page).to have_content "Mean Wind Speed: #{condition_1.mean_wind_speed}"
      expect(page).to have_content "Precipitation: #{condition_1.precipitation}"
      expect(page).to have_button 'Edit'
      expect(page).to have_button 'Delete'
    end
  end
  describe 'visiting conditions/new' do
    it 'can create a new condition' do
      admin = User.create!(username:'dhdf', password:'hello', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_condition_path

      fill_in :condition_cond_date, with: '8/9/2010'
      fill_in :condition_max_temperature, with: 90
      fill_in :condition_mean_temperature, with: 93
      fill_in :condition_min_temperature, with: 89
      fill_in :condition_mean_humidity, with: 76
      fill_in :condition_mean_visibility, with: 5
      fill_in :condition_mean_wind_speed, with: 6
      fill_in :condition_precipitation, with: 7

      click_on "Create Condition"

      expect(page).to have_content "Date: 2010-09-08"
      expect(page).to have_content "Max Temperature: 90"
      expect(page).to have_content "Mean Temperature: 93"
      expect(page).to have_content "Min Temperature: 89"
      expect(page).to have_content "Mean Humidity: 76"
      expect(page).to have_content "Mean Visibility: 5"
      expect(page).to have_content "Mean Wind Speed: 6"
      expect(page).to have_content "Precipitation: 7"
      expect(page).to have_content "You have successfully created 2010-09-08 condition"
    end
  end
  describe 'visiting conditions/edit' do
    it 'can edit a condition' do
      admin = User.create!(username:'dhdf', password:'hello', role: 1)
      condition_1 = Condition.create(cond_date: '8/9/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit edit_admin_condition_path(condition_1)

      fill_in :condition_cond_date, with: '8/10/2010'
      fill_in :condition_max_temperature, with: 90
      fill_in :condition_mean_temperature, with: 93
      fill_in :condition_min_temperature, with: 89
      fill_in :condition_mean_humidity, with: 76
      fill_in :condition_mean_visibility, with: 5
      fill_in :condition_mean_wind_speed, with: 6
      fill_in :condition_precipitation, with: 7

      click_on "Update Condition"

      expect(current_path).to eq condition_path(condition_1)
      expect(page).to have_content "Date: 2010-10-08"
      expect(page).to have_content "Max Temperature: 90"
      expect(page).to have_content "Mean Temperature: 93"
      expect(page).to have_content "Min Temperature: 89"
      expect(page).to have_content "Mean Humidity: 76"
      expect(page).to have_content "Mean Visibility: 5"
      expect(page).to have_content "Mean Wind Speed: 6"
      expect(page).to have_content "Precipitation: 7"
      expect(page).to have_content "You have successfully updated condition for 2010-10-08"
    end
  end
  describe 'visiting conditions/index' do
    it 'can delete a condtion' do
      condition_1 = Condition.create(cond_date: '8/9/2010', max_temperature: 96, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 5, mean_wind_speed: 3, precipitation: 0.2)
      condition_2 = Condition.create(cond_date: '8/10/2010', max_temperature: 86, mean_temperature: 90, min_temperature: 87, mean_humidity: 23, mean_visibility: 2, mean_wind_speed: 6, precipitation: 0.6)
      admin = User.create!(username:'dhdf', password:'hello', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit conditions_path

      within "#condition-#{condition_1.id}" do
        click_button 'Delete'
      end

      expect(current_path).to eq conditions_path
      expect(page).to have_content "Date: #{condition_2.cond_date}"
      expect(page).to_not have_content "Date: #{condition_1.cond_date}"
      expect(page).to have_content "You have successfully deleted #{condition_1.cond_date} condition"
    end
  end
end
