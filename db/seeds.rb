# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require './app/models/condition.rb'
require 'csv'

Accessory.create(title: "WELLGO Alloy BMX Mountain Bike Pedals Sealed 9/16", description: "The WELLGO Alloy BMX Mountain Bike Pedals are sealed bearing pedals perfect for MTB or BMX riding. They come in black and white, and have an aluminum body with a Cr-Mo spindle measuring 9/16 inch.", price: 20, image: "https://dauol55rp0uws.cloudfront.net/media/catalog/product/cache/5/thumbnail/800x600/9df78eab33525d08d6e5fb8d27136e95/0/0/001-WP-A52__01.jpg_3.jpg")
Accessory.create(title: "SRAM PC-850 8-Speed Chain", description: "SRAM's PC-850 Chain makes a trusty partner over hill and dale. It's easy to install, too, thanks to the no-tools-needed PowerLink. Quiet, smooth, reliable and very affordable, the PC-850 is a fine value.", price: 8, image: "https://cdn.shopify.com/s/files/1/0286/1214/products/sram_pc850_08_m_x700.jpeg?v=1465496927")
Accessory.create(title: "Avid 20R Brake Pads", description: "Bolt on Avid's 20R Brake Pads for consistent, powerful braking. They're designed for use with linear-pull brakes.", price: 25, image: "https://cdn.shopify.com/s/files/1/0286/1214/products/BR4606_x700.jpeg?v=1464530473")
Accessory.create(title: "Shimano Altus Rear Derailleur 7/8 Speed", description: "ALTUS is a 7/8-speed MTB-style component group for city sport and youth bikes.", price: 30, image: "https://cdn.shopify.com/s/files/1/0286/1214/products/RD3100_x700.jpg?v=1501626175")
Accessory.create(title: "Crank Brothers Egg Beater 11 Titanium Pedals", description: "Pro-level XC/Race pedal is minimal and lightweight with 4-sided entry for superior mud shedding.", price: 360, image: "https://cdn.shopify.com/s/files/1/0286/1214/products/PD8220_x700.jpg?v=1527706215")
Accessory.create(title: "Shimano PD-M520 Pedals", description: "The Shimano M520s work well for either roadies or mountain bikers. They're affordable, easy to enter and exit, and built to last.", price: 36, image: "https://cdn.shopify.com/s/files/1/0286/1214/products/df5c3cd02bb7381028b840b7f5546f3c_x700.jpeg?v=1496881389")
Accessory.create(title: "Giant Comfort LX Grips", description: "For maximum comfort and control, check out Giant's Comfort LX Grips. The dual-compound design features soft-density rubber on the main contact areas for padding, while the inner cores have a firm rubber for a secure attachment to the handlebars.", price: 12, image: "https://cdn.shopify.com/s/files/1/0286/1214/products/ff0bc1a791313cd8f6f3475f3c40a486_df50606b-25f9-4eda-8e06-0622990c8ad5_x700.jpeg?v=1525314907")
Accessory.create(title: "Ergon GE1 Grips", description: "Specially designed for Enduro riding where handlebars are wider and typically gripped at the ends of the bars. Two rubber compounds and textured zones are orientated against the hands for optimum control and less hand tension.", price: 28, image: "https://cdn.shopify.com/s/files/1/0286/1214/products/G0000W2M_x700.jpg?v=1490741505")
Accessory.create(title: "KMC 510H BMX/Cruiser Chain", description: "Bushingless construction with thicker side plates", price: 20, image: "https://cdn.shopify.com/s/files/1/0286/1214/products/chan1008_x700.jpg?v=1467219777")
Accessory.create(title: "Spank Oozy Trail 345 Boost 27.5\" Wheelset", description: "All the benefits of Boost spacing, in a wide, trail optimized package. Spank Industries’ OOZY Trail 345 wheelset is hand built and trued to industry leading standards.", price: 520, image: "https://cdn.shopify.com/s/files/1/0286/1214/products/SPA-OOZY-TRAIL345-BST-WHL_x700.jpg?v=1493881971")
Accessory.create(title: "Santa Cruz Reserve Carbon 30 27'5\" I9 HG 110 Wheelset", description: "Whether it's a sunset lap with friends or a race run against the clock, a broken wheel ruins any ride. Santa Cruz set strength and impact resistance as their highest priority, but strength doesn't have to mean uncomfortably stiff.", price: 1520, image: "https://cdn.shopify.com/s/files/1/0286/1214/products/sc-reserve-wheelset_f67147b5-e04d-47fa-97b1-85e343c9248e_x700.jpg?v=1515112879")
Accessory.create(title: "SRAM GX 1x11 Speed Long Cage Rear Derailleur", description: "GX derailleurs share the key features of higher-priced models and are available for 1x11 and 2x11 drive trains.", price: 95, image: "https://cdn.shopify.com/s/files/1/0286/1214/products/RD6129_x700.jpg?v=1501620140")


CSV.foreach('./db/csv/weather.csv', headers: true, header_converters: :symbol) do |condition|
  condition_date = Date.strptime(condition[:date], '%m/%d/%Y')

  if condition[:zip_code] == '94107'
    Condition.create(cond_date: Date.strptime(condition[:date], '%m/%d/%Y'),
                     max_temperature: condition[:max_temperature_f],
                     mean_temperature: condition[:mean_temperature_f],
                     min_temperature: condition[:min_temperature_f],
                     mean_humidity: condition[:mean_humidity],
                     mean_visibility: condition[:mean_visibility_miles],
                     mean_wind_speed: condition[:mean_wind_speed_mph],
                     precipitation: condition[:precipitation_inches]
                  )
  end
end

CSV.foreach('./db/csv/station.csv', headers: true, header_converters: :symbol) do |station|
  Station.create(name: station[:name],
                 city: station[:city],
                 dock_count: station[:dock_count],
                 installation_date: DateTime.strptime(station[:installation_date], '%m/%d/%Y')
                )
end


@random = Random.new
CSV.foreach('./db/csv/trip.csv', headers: true, header_converters: :symbol) do |trip|
  if @random.rand(50) == 26
    Trip.create(duration: trip[:duration],
                start_date: DateTime.strptime(trip[:start_date], '%m/%d/%Y %H:%M'),
                start_station_id: trip[:start_station_id].to_i,
                end_date: DateTime.strptime(trip[:end_date], '%m/%d/%Y %H:%M'),
                end_station_id: trip[:end_station_id].to_i,
                bike_id: trip[:bike_id],
                subscription_type: trip[:subscription_type],
                zip_code: trip[:zip_code]
              )
  end
end


ActiveRecord::Base.connection.reset_pk_sequence!('stations')
