require 'rails_helper'

describe 'A user visits the dashboard' do
  context 'as a registered user' do
    xit 'can click a link and update its own information' do
      user = User.create(username: 'Dude', password: 'huISER3')
      new_name = 'Bud'
      new_password = 'Bong420'

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      click_on 'Edit Profile'

      expect(current_path).to eq(new_user_path(user))

      fill_in :user_username, with: new_name
      fill_in :user_password, with: new_name

      click_on 'Update User'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Logged in as #{new_namen }")
    end
  end
end
