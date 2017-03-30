# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# user = CreateAdminService.new.call
# puts 'CREATED ADMIN USER: ' << user.email



# Environment variables (ENV['...']) can be set in the file .env file.

# Agency.create!([{
#   name: "North Carolina Community College System",
#   address: "200 West Jones Street",
#   city: "Raleigh",
#   state: "NC",
#   zipcode: "27603",
#   phone: "(919) 807-7140",
#   description: "Education services provided to English language
#     learners who are adults, that enables them to achieve
#     competency in the English language and acquire the basic and
#     more advanced skills. ",
#   contact: "Karen Brown"
# },
# {
#   name: "Farmworker Advocacy Network (FAN)",
#   address: "1317 W. Pettigrew Street",
#   city: "durham",
#   state: "nc",
#   zipcode: "27705",
#   phone: "(919) 660-3616",
#   description: "Farmworker Advocacy Network is a statewide
#     network of organizations that work to improve living and
#     working conditions of farmworkers and poultry workers in
#     North Carolina. ",
#   contact: "Melinda Wiggins"
# },
# {
#   name: "Legal Aid of NC Battered Immigrant Project",
#   address: "224 S. Dawson Street",
#   city: "Raleigh",
#   state: "nc",
#   zipcode: "27601",
#   phone: "(919) 856-2564",
#   description: "The Battered Immigrant Project (BIP), part of our
#     Domestic Violence Prevention Initiative​, provides
#     comprehensive and culturally appropriate legal services to
#     immigrant survivors of violence needing assistance with
#     immigration. ",
#   contact: "Teandra Miller"
# },
# {
#   name: "Adelante Education Coalition",
#   address: "301 Pittsboro Street",
#   city: "Chapel Hill",
#   state: "nc",
#   zipcode: "27599",
#   phone: "",
#   description: "Adelante focuses on education issues affecting
#     Latino and migrant students and their families in the state.
#     The coalition is a collaboration among nonprofit
#     organizations that focus on advocacy and public policy,
#     community organizing, and grassroots support.",
#   contact: "Ricky Hurtado"
# },
# {
#   name: "Employment Security Commission/Agricultural Services",
#   address: "313 Chapanoke Rd. Ste. 210",
#   city: "raleigh",
#   state: "nc",
#   zipcode: "27611",
#   phone: "(919) 814-0464, (919) 814-0448",
#   description: "NC Works Career Centers’ employment consultants
#     help place farm workers on jobs and ensure that migrant and
#     seasonal farmworkers have access to the same services as the
#     general public. ",
#   contact: "Francisca Rios, Billy Green"
# }])
#
# p "Created #{Agency.count} organizations"

# # using chunks:
# filename = 'DirectorySpreadsheet.csv'
# options = {:chunk_size => 1000, :key_mapping => {:unwanted_row => nil, :old_row_name => :new_name}}
# n = SmarterCSV.process(filename, options) do |chunk|
#       # we're passing a block in, to process each resulting hash / row (block takes array of hashes)
#       # when chunking is enabled, there are up to :chunk_size hashes in each chunk
#       MyModel.collection.insert( chunk )   # insert up to 100 records at a time
# end
#
#  => returns number of chunks we processed

# Require Ruby CSV library to properly parse the CSV data.
require 'csv'

# read CSV file into a variable
csv_text = File.read(Rails.root.join('lib', 'seeds', 'safwDirectory.csv'))
# Converts the CSV into a structure that Ruby can read.
csv = CSV.parse(csv_text, headers: true, encoding: 'UTF-8')
# Loop through the entire CSV file and convert each row of thr document
# into a hash. The headers of the CVS file are used as keys for the hash
csv.each do |row|
  t = Agency.new
  t.name = row['Organization Name']
  t.address = row['Street Address']
  t.city = row['City']
  t.state = row['State']
  t.zipcode = row['Zipcode']
  t.contact = row['Person of Contact']
  t.phone = row['Phone number']
  t.description = row['Descriptions']
  t.email = row['Email']
  t.descripcion = row['Descripciones']
  t.save
  puts "Organization #{t.name} saved!"
  # puts row.to_hash
end

puts "There are now #{Agency.count} rows in the Agency table"
# Print contents of the variable
# puts csv
