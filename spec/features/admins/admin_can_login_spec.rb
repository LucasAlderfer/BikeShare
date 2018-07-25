require 'rails_helper'

describe 'as an admin' do
  it 'can login' do
    admin = User.create!(username:'dhdf', password:'hello', role: 1)

    visit root_path

    click_on "Login"

    fill_in :username, with: admin.username
    fill_in :password, with: admin.password
    click_on "Login"

    expect(current_path).to eq admin_dashboard_path
    expect(page).to have_content "Logged in as Admin User: #{admin.username}"#Add conditional to Nav
    expect(page).to have_content 'Logout'
    expect(page).to_not have_content 'Login'
  end
end
