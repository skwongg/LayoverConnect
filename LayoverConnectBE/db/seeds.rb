# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Terminal.destroy_all
Business.destroy_all
Terminal.create(name: "Terminal 1")
Terminal.create(name: "Terminal 2")
Terminal.create(name: "Terminal 3")
Terminal.create(name: "International Terminal")

response = HTTParty.get('http://www.flysfo.com/api/dining.json?offset=0&limit=70&key='+ENV['SFO_KEY'])
response.each do |place|
  next if place['terminal'] == "Rental Car Center"
  restaurant = Business.new
  restaurant.name = place['node_title']
  restaurant.description = place['body']
  restaurant.location_summary = place['location_summary']
  if place['hours'][0..25] == "24 hours-a-day"
    restaurant.start_time  = DateTime.parse("00:00")
    restaurant.end_time = DateTime.parse("24:00")
  elsif place['hours'].scan(/..:...p.m/).empty?
    restaurant.start_time = DateTime.parse(place['hours'][0..25].scan(/..:...a.m/)[0].strip)
    restaurant.end_time = DateTime.parse("24:00")
  elsif place['hours'][0..25] == nil
    next
  elsif place['hours'][0..25].scan(/..:...a.m/).empty?
    restaurant.start_time = DateTime.parse("04:30")
    restaurant.end_time = DateTime.parse(place['hours'].scan(/..:...p.m/)[0].strip)
  else
    restaurant.start_time = DateTime.parse(place['hours'][0..25].scan(/..:...a.m/)[0].strip)
    restaurant.end_time = DateTime.parse(place['hours'].scan(/..:...p.m/)[0].strip)
  end
  restaurant.image = place['image']
  restaurant.security = false if place['security'] == "Pre-Security"
  Terminal.where(name: place['terminal']).first.businesses << restaurant
  restaurant.save
end
