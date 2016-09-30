class Agency < ApplicationRecord
	def self.search(search)
  	where("name LIKE ? OR city LIKE ? ", "%#{search}%", "%#{search}%")
	end
end