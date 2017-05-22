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
website_types = [
  {
  name: 'Facebook',
  icon: 'facebook'
  },
  {
  name: 'Website',
  icon: 'globe'
  }
  ]
  website_types.each do |website_type|
    type = WebsiteType.find_by(name: website_type[:name])
    if type.nil?
      WebsiteType.create(website_type)
    end
  end
  p "Created #{WebsiteType.count} WebsiteType"

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

  c = Category.find_by(name: row['Category'])
  if c.nil?
    c = Category.new
    c.name = row['Category']
    c.categoria = row['Categoria']
    c.save
  end


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
  # t.save
  if t.save
    t.agency_categories.create(category_id: c.id)
  else
    t.errors
  end

  if row['Website'] and not row['Website'].empty?
    website_type = WebsiteType.find_by(name: 'Website')
    t.websites.create(url: row['Website'], website_type_id: website_type.id)
  end
  if row['Facebook'] and not row['Facebook'].empty?
    website_type = WebsiteType.find_by(name: 'Facebook')
    t.websites.create(url: row['Facebook'], website_type_id: website_type.id)
  end
  puts "Organization #{t.name} saved!"
  puts "Category #{c.name} saved!"
  # puts row.to_hash
end

# HERE I am seeding the FAQs. - Fernando
require 'csv'
csv_text = File.read(Rails.root.join('lib', 'seeds', 'FAQ.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'UTF-8')

csv.each do |column|
  faq = Faq.new
  faq.question = column['question']
  faq.answer = column['answer']
  faq.pregunta = column['pregunta']
  faq.respuesta = column['respuesta']
  faq.save
end


puts "there are #{Faq.count} faqs in the Faq table"
puts "There are now #{Agency.count} rows in the Agency table"
# Print contents of the variable
# puts csv
