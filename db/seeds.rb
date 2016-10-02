# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do
  Donor.create role: 'donor',
               first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name,
               organization_name: Faker::Company.name
end

10.times do
  Receiver.create role: 'receiver',
               first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name,
               organization_name: Faker::Company.name
end


2.times do
  Donor.all.each do |donor|
    donor.donations.create!
  end
end

FOODS = [ 'asparagus',
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
          'Zucchini'
        ]

QUANTITY_TYPES = %w[pound(s) tray(s) unit(s)]

Donation.all.each do |donation|
  rand(1..5).times do
    donation.add_item(FOODS.sample, rand(1..10), QUANTITY_TYPES.sample)
    donation.save!
  end
end
