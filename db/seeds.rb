# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do
  User.create role: %w[donor receiver].sample,
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              organization_name: Faker::Company.name
end

2.times do
  User.all.each do |user|
    user.donations.create! user_id: user.id
  end
end
