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

      visit root_path

      click_on "Login"

      fill_in :username, with: 'Dude'
      fill_in :password, with: 'huISER3'
      click_button 'Login'

      visit root_path

      click_on 'Logout'

      expect(current_path).to eq(root_path)
      expect(page).to_not have_content('Logout')
      expect(page).to have_content('Login')
    end
    it 'shows empty cart on logout' do
      user = User.create(username: 'Dude', password: 'huISER3')
      part_1 = Accessory.create(title: 'thing1', description: 'kjhs', price: 4, status: 0, image: 'http://placekitten/200/200')
      part_2 = Accessory.create(title: 'thing2', description: 'kjhgt6s', price: 6, status: 0, image: 'http://placekitten/200/200')

      visit root_path
      click_on "Login"

      fill_in :username, with: 'Dude'
      fill_in :password, with: 'huISER3'
      click_button 'Login'

      visit '/bike-shop'

      within "#accessory-#{part_1.id}" do
        click_on 'Add to Cart'
      end

      within "#accessory-#{part_2.id}" do
        click_on 'Add to Cart'
      end

      expect(page).to have_content('Cart Count: 2')
      click_on 'Logout'

      expect(page).to have_content('Cart Count: 0')
    end
  end
end
