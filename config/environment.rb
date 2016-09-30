Rails.application.configure do

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

#This is for ssl certificate provided by heroku.
config.force_ssl = true
end