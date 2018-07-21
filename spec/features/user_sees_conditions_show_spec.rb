require 'rails_helper'

describe 'sees condition show page' do
  context 'as a visitor' do
    it 'sees all attributes for one condition' do
      cond1 = Condition.create!(cond_date: '15/8/2015',
                               max_temperature: 75,
                               mean_temperature: 65,
                               min_temperature: 55,
                               mean_humidity: 25,
                               mean_visibility: 5,
                               mean_wind_speed: 10,
                               precipitation: 0.25
                              )

      visit condition_path(cond1)

      expect(page).to have_content(cond1.cond_date)
      expect(page).to have_content(cond1.max_temperature)
      expect(page).to have_content(cond1.mean_temperature)
      expect(page).to have_content(cond1.min_temperature)
      expect(page).to have_content(cond1.mean_humidity)
      expect(page).to have_content(cond1.mean_visibility)
      expect(page).to have_content(cond1.mean_wind_speed)
      expect(page).to have_content(cond1.precipitation)
    end
  end
end
