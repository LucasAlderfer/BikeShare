require 'rails_helper'

describe 'visitor can create account' do
  it 'can create user account' do
    username = 'jorj'
    password = '12345'

    visit '/'
    click_on 'Login'

    expect(current_path).to eq('/login')
    click_on 'Create New Account'

    fill_in :user_username, with: username
    fill_in :user_password, with: password
    click_on 'Submit'

    expect(current_path).to eq('/dashboard')
    within 'nav' do
      expect(page).to have_content("Logged in as #{username}")
    end

    expect(page).to_not have_content('Login')
    expect(page).to have_content('Logout')
  end
  it 'cannot create a user account without a username or a password' do
    username = 'jorj'
    password = '12345'

    visit '/'
    click_on 'Login'

    expect(current_path).to eq('/login')
    click_on 'Create New Account'

    fill_in :user_password, with: password
    click_on 'Submit'

    expect(page).to have_content("Unable to create account.")
  end
end
