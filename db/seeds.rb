Donor.create email:          'donor@donor.com',
             password:       'password',
             agency_name:    Faker::Company.name,
             street_address: Faker::Address.street_address,
             city:           Faker::Address.city,
             state:          Faker::Address.state_abbr,
             zip:            Faker::Address.zip_code,
             contact_name:   Faker::Name.name,
             contact_email:  Faker::Internet.email,
             contact_phone:  Faker::PhoneNumber.cell_phone,
             web_url:        Faker::Internet.url

Receiver.create email:          'receiver@receiver.com',
                password:       'password',
                agency_name:    Faker::Company.name,
                street_address: Faker::Address.street_address,
                city:           Faker::Address.city,
                state:          Faker::Address.state_abbr,
                zip:            Faker::Address.zip_code,
                web_url:        Faker::Internet.url

10.times do
  Donor.create email:          Faker::Internet.email,
               password:       'password',
               agency_name:    Faker::Company.name,
               street_address: Faker::Address.street_address,
               city:           Faker::Address.city,
               state:          Faker::Address.state_abbr,
               zip:            Faker::Address.zip_code,
               contact_name:   Faker::Name.name,
               contact_email:  Faker::Internet.email,
               contact_phone:  Faker::PhoneNumber.cell_phone,
               web_url:        Faker::Internet.url


end

10.times do
Receiver.create email:            Faker::Internet.email,
                  password:       'password',
                  agency_name:    Faker::Company.name,
                  street_address: Faker::Address.street_address,
                  city:           Faker::Address.city,
                  state:          Faker::Address.state_abbr,
                  zip:            Faker::Address.zip_code,
                  web_url:        Faker::Internet.url
end

Admin.create email:    'admin@admin.com',
             password: 'password'


10.times do
  Donation.create donor_id: Donor.all.sample.id
end

['Fruits',
  'Vegetables',
  'Meat',
  'Poultry',
  'Fish',
  'Shellfish',
  'Grains',
  'Dairy',
  'Shelf Stable',
  'Prepared Meal',
  'Faith Based'].each do |name|
  Category.create(
    name: name
  )
end

[ 'asparagus',
  'apples',
  'avacado',
  'alfalfa',
  'acorn squash',
  'almond',
  'arugala',
  'artichoke',
  'applesauce',
  'asian noodles',
  'antelope',
  'ahi tuna',
  'albacore tuna',
  'Apple juice',
  'Avocado roll',
  'Bruscetta',
  'bacon',
  'black beans',
  'bagels',
  'baked beans',
  'BBQ',
  'bison',
  'barley',
  'beer',
  'bisque',
  'bluefish',
  'bread',
  'broccoli',
  'buritto',
  'babaganoosh',
  'Cabbage',
  'cake',
  'carrots',
  'carne asada',
  'celery',
  'cheese',
  'chicken',
  'catfish',
  'chips',
  'chocolate',
  'chowder',
  'clams',
  'coffee',
  'cookies',
  'corn',
  'cupcakes',
  'crab',
  'curry',
  'cereal',
  'chimichanga',
  'dates',
  'dips',
  'duck',
  'dumplings',
  'donuts',
  'eggs',
  'enchilada',
  'eggrolls',
  'English muffins',
  'edimame',
  'eel sushi',
  'fajita',
  'falafel',
  'fish',
  'franks',
  'fondu',
  'French toast',
  'French dip',
  'Garlic',
  'ginger',
  'gnocchi',
  'goose',
  'granola',
  'grapes',
  'green beans',
  'Guancamole',
  'gumbo',
  'grits',
  'Graham crackers',
  'ham',
  'halibut',
  'hamburger',
  'cheeseburger',
  'honey',
  'huenos rancheros',
  'hash browns',
  'hot dogs',
  'haiku roll',
  'hummus',
  'ice cream',
  'Irish stew',
  'Indian food',
  'Italian bread',
  'jambalaya',
  'jelly',
  'jam',
  'jerky',
  'jalapeño',
  'kale',
  'kabobs',
  'ketchup',
  'kiwi',
  'kidney beans',
  'kingfish',
  'lobster',
  'Lamb',
  'Linguine',
  'Lasagna',
  'Meatballs',
  'Moose',
  'Milk',
  'Milkshake',
  'Noodles',
  'Ostrich',
  'Pizza',
  'Pepperoni',
  'Porter',
  'Pancakes',
  'Quesadilla',
  'Quiche',
  'Reuben',
  'Spinach',
  'Spaghetti',
  'Tater tots',
  'Toast',
  'Venison',
  'Waffles',
  'Wine',
  'Walnuts',
  'Yogurt',
  'Ziti',
  'Zucchini' ].each do |food|
  Food.create(name: food.titleize,
              description: Faker::Hipster.sentence,
              storage_temp: ['Refrigerated', 'Frozen', 'Shelf Stable'].sample,
              prepared_meal: [true, false].sample,
              category_id: Category.all.sample.id,
              donor_id: Donor.all.sample.id)
end

Donation.all.each do |donation|
  rand(1..5).times do
    donation.add_item(Food.where(donor_id: donation.donor.id).all.sample, rand(1..10), DonationItem::QUANTITY_TYPES.sample)
  end
  donation.receiver_id = [Receiver.all.sample, nil].sample
  donation.save!
end

Admin.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

['Diabetic',
 'Faith Based',
 'Vegan',
 'Vegetarian',
 'Reduced Sodium',
 'Other',
 'n/a'].each do |name|
    DietaryRestriction.create(
      name: name
  )
end

['Community Donations', 'Feeding America/FEMA', 'Purchased by agency', 'Other', 'n/a'].each do |name|
  Contribution.create(
    name: name
  )
end
['Refrigerated', 'Frozen', 'Shelf Stable'].each do |desc|
  StorageTemp.create(description: desc)
end

Receiver.all.each do |r|
  r.logistics.create(
    transportation_available:    %w[Yes No].sample,
    driver_status:               ['Staff', 'Volunteers', 'Both', 'n/a'].sample,
    insurance_status:            ['Our organization provides insurance to drivers', 'Our drivers have their own private insurance.', 'We do not know the insurance status of our drivers.', 'n/a'].sample,
    vehicle_style:               ['Car', 'Pickup Truck', 'Box Truck', 'Refrigerated Vehicle', 'Other', 'n/a'].sample,
    freezer_type:                ['Upright', 'Walk-in', 'n/a'].sample,
    refrigerator_type:           ['Upright', 'Walk-in', 'n/a'].sample,
    indoor_dry_storage:          %w[Yes No].sample,
    safe_handling_program:       Faker::Commerce.product_name,
    meal_usage:                  ['We provide meals or groceries only.', 'Providing meals is part of a larger program we offer.'].sample,
    meal_distribution_frequency: ['Multiple times per day', 'Daily', 'Multiple times per week', 'Weekly', 'Other', 'n/a'].sample
  )
  r.contact_details.create(
    contact_name:                 Faker::Name.name,
    contact_email:                Faker::Internet.email,
    contact_phone:                Faker::PhoneNumber.cell_phone,
    dfr_contact_name:             Faker::Name.name,
    dfr_contact_cell_phone:       Faker::PhoneNumber.cell_phone,
    dfr_contact_office_phone:     Faker::PhoneNumber.cell_phone,
    dfr_contact_email:            Faker::Internet.email,
    dfr_preferred_contact_method: %w[office cell].sample
  )
end
