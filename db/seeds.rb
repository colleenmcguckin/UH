# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Donor.create email: 'donor@donor.com',
             password: 'password'

Receiver.create email: 'receiver@receiver.com',
                password: 'password'

10.times do
  Donor.create email:     Faker::Internet.email,
               password: 'password'
end

10.times do
  Receiver.create email:     Faker::Internet.email,
                  password: 'password'
end

Admin.create email:    'admin@admin.com',
             password: 'password'


10.times do
  Donation.create donor_id: Donor.all.sample.id
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
  end
  donation.receiver_id = [Receiver.all.sample, nil].sample
  donation.save!
end
