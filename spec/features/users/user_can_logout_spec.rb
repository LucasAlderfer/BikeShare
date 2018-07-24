require 'rails_helper'

describe 'A user visits the root page' do
  context 'not as a registered user' do
    it 'can log in but there is no log out' do
      visit root_path

      expect(page).to have_content('Login')
      expect(page).to_not have_content('Logout')
    end
  end
  context 'as a registered user' do
    it 'can logout from root and see Login but not Logout' do
      user = User.create(username: 'Dude', password: 'huISER3')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      click 'Logout'

      expect(current_path).to eq(root_path)
      expect(page).to_not have_content('Logout')
      expect(page).to have_content('Login')
    end
  end
end
