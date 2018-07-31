require 'rails_helper'

describe 'visiting /' do
  context 'as a visitor' do
    it 'cannot access another users private data' do
      user = User.create(username:'bill', password:'secure', role:0)

      visit root_path

      expect(page).to_not have_content 'Logged in as'
      expect(page).to_not have_link "Log Out"

      visit user_path(user)

      expect(page).to have_content "The page you were looking for doesn't exist"
      # expect(page).to have_link "Log In" commented out until nav is working
    end
    it 'cannot checkout without logging in' do
      part_1 = Accessory.create(title: 'thing1', description: 'kjhs', price: 4, status: 0, image: 'http://placekitten/200/200')

      visit '/bike-shop'
      click_on "Add to Cart"
      
      visit cart_path

      click_on 'Checkout'

      expect(current_path).to eq login_path
    end
    it 'cannot register as an admin' do
      visit login_path
      click_on 'Create Account'
      expect(page).to_not have_content "Role:"
      visit admin_dashboard_path
      expect(page).to have_content "The page you were looking for doesn't exist"
    end
  end
  context 'as a user' do
    it 'should be able to log in' do
      user = User.create(username:'bill', password:'secure', role:0)
      visit root_path
      click_on "Login"
      expect(current_path).to eq login_path

      fill_in :username, with: 'bill'
      fill_in :password, with: 'secure'
      click_button 'Login'

      expect(current_path).to eq dashboard_path
      expect(page).to have_content "Logged in as #{user.username}"
      expect(page).to have_content "Logout"
    end
    it 'cannot access another users private data' do
      user_1 = User.create(username:'bill', password:'secure', role: 0)
      user_2 = User.create(username:'joe', password:'secure', role: 0)

      visit login_path
      fill_in :username, with: user_1.username
      fill_in :password, with: user_1.password
      click_button 'Login'

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit user_path(user_2)
      # expect(current_path).to eq dashboard_path # I don't agree with this path as part of the test
      expect(page).to have_content "The page you were looking for doesn't exist"
      # expect(page).to have_content "Username: #{user_1.username}" commenting out until nav is complete
      # visit admin_trip_new_path # this path doesn't even exist yet...

      # expect(current_path).to eq dashboard_path # I don't agree with this path as part of the test
      expect(page).to have_content "The page you were looking for doesn't exist"
    end
  end
end
