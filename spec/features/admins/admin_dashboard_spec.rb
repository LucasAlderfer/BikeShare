require 'rails_helper'

describe 'An admin visits admin dashboard' do
  it 'sees a list of all orders with all info' do
    user1 = User.create(username: 'bob', password: '12345')
    user2 = User.create(username: 'fred', password: '54321')
    acc1 = Accessory.create(title: 'bike thing', description: 'does things', price: 2, status: 'Active', image: 'pic.jpg')
    acc2 = Accessory.create(title: 'other thing', description: 'does others', price: 4, status: 'Active', image: 'img.jpg')
    order_1 = user1.orders.create(status: 1, first_name: 'Bob', last_name: 'Jones', street: '123 Main St', city: 'Denver', state: 'CO', zip: 12345)
    order_2 = user2.orders.create(status: 3, first_name: 'Fred', last_name: 'Smith', street: '567 Main St', city: 'Denver', state: 'CO', zip: 54321)
    order_3 = user1.orders.create(status: 2, first_name: 'Bob', last_name: 'Jones', street: '123 Main St', city: 'Denver', state: 'CO', zip: 12345)
    order_4 = user2.orders.create(status: 0, first_name: 'Fred', last_name: 'Smith', street: '567 Main St', city: 'Denver', state: 'CO', zip: 54321)
    order_acc1 = order_1.order_accessories.create(quantity: 2, accessory_id: acc1.id)
    order_acc2 = order_2.order_accessories.create(quantity: 1, accessory_id: acc2.id)
    order_acc3 = order_3.order_accessories.create(quantity: 2, accessory_id: acc1.id)
    order_acc4 = order_4.order_accessories.create(quantity: 1, accessory_id: acc2.id)


    admin = User.create(username: 'dave', password: '98765', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    find_link("Order Number: #{order_1.id} - #{order_1.status}").visible?
    find_link("Order Number: #{order_2.id} - #{order_2.status}").visible?
    expect(page).to have_content("Ordered: 1")
    expect(page).to have_content("Paid: 1")
    expect(page).to have_content("Cancelled: 1")
    expect(page).to have_content("Completed: 1")
  end
  it 'can choose which orders to view' do
    user1 = User.create(username: 'bob', password: '12345')
    user2 = User.create(username: 'fred', password: '54321')
    acc1 = Accessory.create(title: 'bike thing', description: 'does things', price: 2, status: 'Active', image: 'pic.jpg')
    acc2 = Accessory.create(title: 'other thing', description: 'does others', price: 4, status: 'Active', image: 'img.jpg')
    order_1 = user1.orders.create(status: 1, first_name: 'Bob', last_name: 'Jones', street: '123 Main St', city: 'Denver', state: 'CO', zip: 12345)
    order_2 = user2.orders.create(status: 3, first_name: 'Fred', last_name: 'Smith', street: '567 Main St', city: 'Denver', state: 'CO', zip: 54321)
    order_3 = user1.orders.create(status: 2, first_name: 'Bob', last_name: 'Jones', street: '123 Main St', city: 'Denver', state: 'CO', zip: 12345)
    order_4 = user2.orders.create(status: 0, first_name: 'Fred', last_name: 'Smith', street: '567 Main St', city: 'Denver', state: 'CO', zip: 54321)
    order_acc1 = order_1.order_accessories.create(quantity: 2, accessory_id: acc1.id)
    order_acc2 = order_2.order_accessories.create(quantity: 1, accessory_id: acc2.id)
    order_acc3 = order_3.order_accessories.create(quantity: 2, accessory_id: acc1.id)
    order_acc4 = order_4.order_accessories.create(quantity: 1, accessory_id: acc2.id)


    admin = User.create(username: 'dave', password: '98765', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path
    click_on 'Ordered'

    expect(page).to have_content("Order Number: #{order_4.id} - #{order_4.status}")
    expect(page).to_not have_content("Order Number: #{order_3.id} - #{order_3.status}")
  end
  it 'can change status of orders' do
    user1 = User.create(username: 'bob', password: '12345')
    user2 = User.create(username: 'fred', password: '54321')
    acc1 = Accessory.create(title: 'bike thing', description: 'does things', price: 2, status: 'Active', image: 'pic.jpg')
    acc2 = Accessory.create(title: 'other thing', description: 'does others', price: 4, status: 'Active', image: 'img.jpg')
    order_1 = user1.orders.create(status: 1, first_name: 'Bob', last_name: 'Jones', street: '123 Main St', city: 'Denver', state: 'CO', zip: 12345)
    order_2 = user2.orders.create(status: 3, first_name: 'Fred', last_name: 'Smith', street: '567 Main St', city: 'Denver', state: 'CO', zip: 54321)
    order_3 = user1.orders.create(status: 2, first_name: 'Bob', last_name: 'Jones', street: '123 Main St', city: 'Denver', state: 'CO', zip: 12345)
    order_4 = user2.orders.create(status: 0, first_name: 'Fred', last_name: 'Smith', street: '567 Main St', city: 'Denver', state: 'CO', zip: 54321)
    order_acc1 = order_1.order_accessories.create(quantity: 2, accessory_id: acc1.id)
    order_acc2 = order_2.order_accessories.create(quantity: 1, accessory_id: acc2.id)
    order_acc3 = order_3.order_accessories.create(quantity: 2, accessory_id: acc1.id)
    order_acc4 = order_4.order_accessories.create(quantity: 1, accessory_id: acc2.id)


    admin = User.create(username: 'dave', password: '98765', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    click_on 'Ordered'

    click_on 'Cancel'

    click_on 'Cancelled'

    expect(page).to have_content("Order Number: #{order_4.id} - cancelled")

    visit admin_dashboard_path

    click_on 'Paid'

    click_on 'Cancel'

    click_on 'Cancelled'

    expect(page).to have_content("Order Number: #{order_2.id} - cancelled")
  end
  it 'can change status of orders ordered to paid' do
    user1 = User.create(username: 'bob', password: '12345')
    user2 = User.create(username: 'fred', password: '54321')
    acc1 = Accessory.create(title: 'bike thing', description: 'does things', price: 2, status: 'Active', image: 'pic.jpg')
    acc2 = Accessory.create(title: 'other thing', description: 'does others', price: 4, status: 'Active', image: 'img.jpg')
    order_1 = user1.orders.create(status: 1, first_name: 'Bob', last_name: 'Jones', street: '123 Main St', city: 'Denver', state: 'CO', zip: 12345)
    order_2 = user2.orders.create(status: 3, first_name: 'Fred', last_name: 'Smith', street: '567 Main St', city: 'Denver', state: 'CO', zip: 54321)
    order_3 = user1.orders.create(status: 2, first_name: 'Bob', last_name: 'Jones', street: '123 Main St', city: 'Denver', state: 'CO', zip: 12345)
    order_4 = user2.orders.create(status: 0, first_name: 'Fred', last_name: 'Smith', street: '567 Main St', city: 'Denver', state: 'CO', zip: 54321)
    order_acc1 = order_1.order_accessories.create(quantity: 2, accessory_id: acc1.id)
    order_acc2 = order_2.order_accessories.create(quantity: 1, accessory_id: acc2.id)
    order_acc3 = order_3.order_accessories.create(quantity: 2, accessory_id: acc1.id)
    order_acc4 = order_4.order_accessories.create(quantity: 1, accessory_id: acc2.id)


    admin = User.create(username: 'dave', password: '98765', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    click_on 'Ordered'

    click_on 'Mark as Paid'

    click_on 'Paid'

    expect(page).to have_content("Order Number: #{order_4.id} - paid")
  end
  it 'can change status of orders paid to completed' do
    user1 = User.create(username: 'bob', password: '12345')
    user2 = User.create(username: 'fred', password: '54321')
    acc1 = Accessory.create(title: 'bike thing', description: 'does things', price: 2, status: 'Active', image: 'pic.jpg')
    acc2 = Accessory.create(title: 'other thing', description: 'does others', price: 4, status: 'Active', image: 'img.jpg')
    order_1 = user1.orders.create(status: 1, first_name: 'Bob', last_name: 'Jones', street: '123 Main St', city: 'Denver', state: 'CO', zip: 12345)
    order_2 = user2.orders.create(status: 3, first_name: 'Fred', last_name: 'Smith', street: '567 Main St', city: 'Denver', state: 'CO', zip: 54321)
    order_3 = user1.orders.create(status: 2, first_name: 'Bob', last_name: 'Jones', street: '123 Main St', city: 'Denver', state: 'CO', zip: 12345)
    order_4 = user2.orders.create(status: 0, first_name: 'Fred', last_name: 'Smith', street: '567 Main St', city: 'Denver', state: 'CO', zip: 54321)
    order_acc1 = order_1.order_accessories.create(quantity: 2, accessory_id: acc1.id)
    order_acc2 = order_2.order_accessories.create(quantity: 1, accessory_id: acc2.id)
    order_acc3 = order_3.order_accessories.create(quantity: 2, accessory_id: acc1.id)
    order_acc4 = order_4.order_accessories.create(quantity: 1, accessory_id: acc2.id)


    admin = User.create(username: 'dave', password: '98765', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    click_on 'Paid'

    click_on 'Mark as Completed'

    click_on 'Completed'

    expect(page).to have_content("Order Number: #{order_3.id} - completed")
  end
end
