# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

listings = Listing.create([
  {user_id: 1, title: "Awesome Ad Space (Tama)", category: "Billboard", description: "Life is too short for shitty ads (space)", width: 20, height: 30, base_amount: 100, recurring_amount: 50.95, is_available: true, phone: "1231231234", ref_id: "vd-2342", charge_frequency: "yearly", company_name: "Best Ad Provider", min_lease_days: 30},
  {user_id: 1, title: "Awesome Ad Space #2 (Tyco)", category: "Bus Stop", description: "Life is too short for shitty ads (space)", width: 50, height: 80, base_amount: 150.99, recurring_amount: 100.95, is_available: false, phone: "1231231235", charge_frequency: "monthly" ,ref_id: "sf-2342", company_name: "Best Ad Provider", min_lease_days: 31}
])

addresses = Address.create([
  {listing_id: 1, line_1: "1849 Union St", line_2: "5th St", city: "San Francisco", state: "CA", zipcode: "94123", country: "US"},
  {listing_id: 2, line_1: "620 O'Farrell St", line_2: "4th St", city: "San Francisco", state: "CA", zipcode: "94109", country: "US"}
])

messages = Message.create([
  {listing_id: 1, sender_id: 2, recipient_id: 1, subject: "I'm super intersted in your ad space!", body: "super interested, please send me more info!", start_date: Date.current, end_date: 1.month.from_now.to_date},
  {listing_id: 1, sender_id: 1, recipient_id: 2, subject: "RE:I'm super intersted in your ad space!", body: "Yes! what is your ad's content gonna be about?"}
])



listing = Listing.create(user_id: 1, title: 'Sign A', category: "Bench Ad", description: "A sign", width: 20, height:30, base_amount: 200, recurring_amount: 50, is_available: true, phone: '1234567890', ref_id: "vd-1234", charge_frequency: "momthly", company_name: "Some Signs", min_lease_days: 30)
puts listing.inspect
address = Address.create(
listing_id: listing.id,
line_1: '2320 Lombard St',
city: 'San Francisco',
state: 'CA',
zipcode: 94123,
country: 'US'
)
puts address.inspect
listing = Listing.create(user_id: 1, title: 'Sign B' , category: "Billboard", description: "A sign", width: 20, height:30, base_amount: 200, recurring_amount: 50, is_available: true, phone: '1234567890', ref_id: "vd-1234", charge_frequency: "momthly", company_name: "Some Signs", min_lease_days: 30)
puts listing.inspect
address = Address.create(
listing_id: listing.id,
line_1: '66 Mint St',
city: 'San Francisco',
state: 'CA' ,
zipcode: 94103,
country: 'US'
)
puts address.inspect
listing = Listing.create(user_id: 1, title: 'Sign C', category: "Bus Stop Ad", description: "A sign", width: 20, height:30, base_amount: 200, recurring_amount: 50, is_available: true, phone: '1234567890', ref_id: "vd-1234", charge_frequency: "momthly", company_name: "Some Signs", min_lease_days: 30)
puts listing.inspect
address = Address.create(
listing_id: listing.id,
line_1: '2821 California St',
city: 'San Francisco',
state: 'CA',
zipcode: 94115,
country: 'US'
)
puts address.inspect
listing = Listing.create(user_id: 1, title: 'Sign D', category: "Billboard", description: "A sign", width: 20, height:30, base_amount: 200, recurring_amount: 50, is_available: true, phone: '1234567890', ref_id: "vd-1234", charge_frequency: "momthly", company_name: "Some Signs", min_lease_days: 30)
puts listing.inspect
address = Address.create(
listing_id: listing.id,
line_1: '270 7th St',
city: 'San Francisco',
state: 'CA',
zipcode: 94103,
country: 'US'
)
puts address.inspect
listing = Listing.create(user_id: 1, title: 'Sign E', category: "Bus Stop Ad", description: "A sign", width: 20, height:30, base_amount: 200, recurring_amount: 50, is_available: true, phone: '1234567890', ref_id: "vd-1234", charge_frequency: "momthly", company_name: "Some Signs", min_lease_days: 30)
puts listing.inspect
address = Address.create(
listing_id: listing.id,
line_1: '375 Valencia St',
city: 'San Francisco',
state: 'CA ',
zipcode: 94103,
country: 'US'
)
puts address.inspect
listing = Listing.create(user_id: 1, title: 'Sign F', category: "Billboard", description: "A sign", width: 20, height:30, base_amount: 200, recurring_amount: 50, is_available: true, phone: '1234567890', ref_id: "vd-1234", charge_frequency: "momthly", company_name: "Some Signs", min_lease_days: 30)
puts listing.inspect
address = Address.create(
listing_id: listing.id,
line_1: '2340 Polk St',
city: 'San Francisco',
state: 'CA ',
zipcode: 94109,
country: 'US'
)
puts address.inspect
listing = Listing.create(user_id: 1, title: 'Sign G', category: "Bench Ad", description: "A sign", width: 20, height:30, base_amount: 200, recurring_amount: 50, is_available: true, phone: '1234567890', ref_id: "vd-1234", charge_frequency: "momthly", company_name: "Some Signs", min_lease_days: 30)
puts listing.inspect
address = Address.create(
listing_id: listing.id,
line_1: '537 Octavia St',
city: 'San Francisco',
state: 'CA ',
zipcode: 94102,
country: 'US'
)
puts address.inspect
listing = Listing.create(user_id: 1, title: 'Sign H', category: "Billboard", description: "A sign", width: 20, height:30, base_amount: 200, recurring_amount: 50, is_available: true, phone: '1234567890', ref_id: "vd-1234", charge_frequency: "momthly", company_name: "Some Signs", min_lease_days: 30)
puts listing.inspect
address = Address.create(
listing_id: listing.id,
line_1: '315 Linden St',
city: 'San Francisco',
state: 'CA',
zipcode: 94102,
country: 'US'
)
puts address.inspect
listing = Listing.create(user_id: 1, title: 'Sign I', category: "Bench Ad", description: "A sign", width: 20, height:30, base_amount: 200, recurring_amount: 50, is_available: true, phone: '1234567890', ref_id: "vd-1234", charge_frequency: "momthly", company_name: "Some Signs", min_lease_days: 30)
puts listing.inspect
address = Address.create(
listing_id: listing.id,
line_1: '240 Ritch St',
city: 'San Francisco',
state: 'CA',
zipcode: 94107,
country: 'US'
)
puts address.inspect
