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
                web_url:        'www.google.com',
                street_address: Faker::Address.street_address,
                city:           Faker::Address.city,
                state:          Faker::Address.state_abbr,
                zip:            Faker::Address.zip_code

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
                  web_url:        'www.google.com'
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
    insurance_status:            ['Our organization provides insurance to drivers', 'Our drivers have their own private insurance.', 'n/a'].sample,
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
  r.demographics.create(
    percent_male: 20,
    percent_female: 20,
    percent_other_gender: 20,
    percent_youth: 20,
    percent_adult: 20,
    percent_senior: 20,
    percent_american_native: 20,
    percent_african_american: 20,
    percent_asian: 20,
    percent_hispanic: 20,
    percent_pacific_islander: 20,
    percent_white: 20,
    percent_portuguese: 20,
    percent_single_no_kids: 20,
    percent_single_with_kids: 20,
    percentage_married_no_kids: 20,
    percentage_married_with_kids: 20,
    precent_employed: 20,
    percent_unemployed: 20,
    percent_veteran_military: 20,
    percent_active_military: 20,
    percentage_with_dietary_restrictions: 20,
    total_guests_served_per_week: [50, 100, 500, 1000].sample,
    meals_served_per_breakfast: [50, 100, 500, 1000].sample,
    meals_served_per_lunch: [50, 100, 500, 1000].sample,
    meals_served_per_dinner: [50, 100, 500, 1000].sample,
    total_receiving_groceries: [50, 100, 500, 1000].sample,
    mode_of_transportation: [50, 100, 500, 1000].sample,
    distance_traveled: [50, 100, 500, 1000].sample,
  )

  Receiver.create(
    email:          'unionstation@receiver.com',
    password:       'password',
    agency_name:    'Union Station Adult Center',
    street_address: '412 S. Raymond St.',
    city:           'Pasadena',
    state:          'CA',
    zip:            '91104',
    tax_id:         '123456789'
  )

  Receiver.create(
    email:          'friendsindeed@receiver.com',
    password:       'password',
    agency_name:    'Friends In Deed',
    street_address: '444 E. East Washington',
    city:           'Pasadena',
    state:          'CA',
    zip:            '91104',
    tax_id:         '123456789'
  )

  Receiver.create(
    email:          'losangelesmission@receiver.com',
    password:       'password',
    agency_name:    'The Los Angeles Mission',
    street_address: '303 East 5th Street',
    city:           'Los Angeles',
    state:          'CA',
    zip:            '90013',
    tax_id:         '123456789'
  )

  Receiver.create(
    email:          'losangelesmission@receiver.com',
    password:       'password',
    agency_name:    'SOVA Family Services',
    street_address: '6439 Vanowen St.',
    city:           'Van Nuys',
    state:          'CA',
    zip:            '91406',
    tax_id:         '123456789'
  )

  Receiver.create(
    email:          'gilroycompassioncenter@receiver.com',
    password:       'password',
    agency_name:    'Gilroy Compassion Center',
    street_address: '370 Thomkins Court',
    city:           'Gilroy',
    state:          'CA',
    zip:            '95020',
    tax_id:         '123456789'
  )

  Receiver.create(
    email:          'homefirst@receiver.com',
    password:       'password',
    agency_name:    'Home First-Sobrato House Youth Center',
    street_address: '496 S. 3rd Street',
    city:           'San Jose',
    state:          'CA',
    zip:            '95112',
    tax_id:         '123456789'
  )

  Receiver.create(
    email:          'tricityvalley@receiver.com',
    password:       'password',
    agency_name:    'Tri-City Valley Food Bank',
    street_address: '37350 Joseph St.',
    city:           'Fremont',
    state:          'CA',
    zip:            '94536',
    tax_id:         '123456789'
  )

end
