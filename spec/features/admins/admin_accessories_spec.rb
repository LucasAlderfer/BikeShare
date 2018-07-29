require 'rails_helper'

describe 'Admin' do
  describe 'visits dashboard' do
    it 'sees a link for viewing all accessories' do
      admin = User.create(username: "sadf", password: "sadfkj", role: 1)

      product_1 = Accessory.create(title: "asdf", price: 23, status: 0, description: "jkhfs", image: "http://placekitten.com/200/200")
      product_2 = Accessory.create(title: "sdfkjl", price: 23, status: 0, description: "kjfds", image: "http://placekitten.com/200/200")
      product_3 = Accessory.create(title: "sdfklj", price: 23, status: 1, description: "jkhfs", image: "http://placekitten.com/200/200")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      expect(page).to have_link("Accessories")

      click_link("Accessories")

      expect(current_path).to eq(admin_bikeshops_path) # /admin/bike-shop
      expect(page).to have_content("Title: #{product_1.title}")
      expect(page).to have_content("Description: #{product_1.description}")
      expect(page).to have_content("Price: $#{product_1.price}")
      expect(page).to have_content("Status: Active")
      expect(page).to have_css("img[src*='#{product_1.image}']")
      expect(page).to have_content("Title: #{product_3.title}")
      expect(page).to have_content("Description: #{product_3.description}")
      expect(page).to have_content("Price: $#{product_3.price}")
      expect(page).to have_content("Status: Retired")
      expect(page).to have_css("img[src*='#{product_3.image}']")

      within("#accessory-#{product_1.id}") do
        expect(page).to have_button("Edit")
        expect(page).to have_content("Status: Active")
        click_on("Change Status")
      end

      within("#accessory-#{product_1.id}") do
        expect(page).to have_content("Status: Retired")
        click_on("Edit")
      end

      expect(current_path).to eq(edit_admin_bikeshop_path(product_1))

      fill_in :accessory_title, with: "sdffsdkjh"
      fill_in :accessory_description, with: "fskjdf"
      fill_in :accessory_price, with: 75
      fill_in :accessory_image, with: "http://placekitten.com/150/150"
      select "Active", from: :accessory_status
      click_on("Update Accessory")

      expect(current_path).to eq(admin_bikeshops_path)
      within("#accessory-#{product_1.id}") do
        expect(page).to have_content("Title: sdffsdkjh")
        expect(page).to have_content("Description: fskjdf")
        expect(page).to have_content(75)
        expect(page).to have_content("Status: Active")
        expect(page).to have_css("img[src*='http://placekitten.com/150/150']")
      end
    end
    it 'can create a new accessory' do
      admin = User.create(username: "sadf", password: "sadfkj", role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_bikeshop_path

      fill_in :accessory_title, with: "sdf"
      fill_in :accessory_price, with: 45.23
      fill_in :accessory_description, with: "dsfkjhds"
      fill_in :accessory_image, with: "http://placekitten.com/200/200"
      click_on("Create Accessory")

      expect(current_path).to eq(admin_bikeshops_path)
      expect(page).to have_content("Title: sdf")
      expect(page).to have_content("Price: $45.23")
      expect(page).to have_content("Description: dsfkjhds")
      expect(page).to have_css("img[src*='http://placekitten.com/200/200']")
    end
  end
end
