require 'rails_helper'

describe 'A user visits bike shop' do
  describe 'it sees a list of items' do
    xit 'can add individual accessories to a shopping cart' do
      part_1 = Accessory.create(title: 'thing1', description: 'kjhs', price: 4, status: 1, image: 'hjtkhtjk')
      part_2 = Accessory.create(title: 'thing2', description: 'kjhgt6s', price: 6, status: 1, image: 'IIIII')

      visit '/bike-shop'

      within "#accessory-#{part_1.id}" do
        click_on 'Add to Cart'
      end

      expect(page).to have_content("You have added #{part_1.title} to your cart.")

      visit root_path

      expect(page).to have_content('Cart Count: 1')
    end
  end
end
