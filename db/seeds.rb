# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file .env file.

(0..50).each do |p|
  Agency.create(    name: Faker::Company.name, 
                 address: Faker::Address.street_address,
                    city: Faker::Address.city,
                zip_code: Faker::Address.zip,
                   state: Faker::Address.state_abbr
                )
end
