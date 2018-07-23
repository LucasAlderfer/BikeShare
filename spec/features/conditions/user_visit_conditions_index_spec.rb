require 'rails_helper'

describe 'sees conditions index' do
  context 'as a visitor' do
    it 'sees all conditions, each with all attributes' do
      cond1 = Condition.create!(cond_date: '15/8/2015',
                               max_temperature: 75,
                               mean_temperature: 65,
                               min_temperature: 55,
                               mean_humidity: 25,
                               mean_visibility: 5,
                               mean_wind_speed: 10,
                               precipitation: 0.25
                              )
      cond2 = Condition.create!(cond_date: '20/8/2015',
                               max_temperature: 70,
                               mean_temperature: 60,
                               min_temperature: 50,
                               mean_humidity: 30,
                               mean_visibility: 3,
                               mean_wind_speed: 5,
                               precipitation: 0.5
                              )

      visit conditions_path

      expect(page).to have_content(cond1.cond_date)
      expect(page).to have_content(cond1.mean_temperature)
      expect(page).to have_content(cond1.mean_humidity)
      expect(page).to have_content(cond2.max_temperature)
      expect(page).to have_content(cond2.mean_visibility)
      expect(page).to have_content(cond2.precipitation)
    end
  end
end
