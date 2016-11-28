class Agency < ApplicationRecord
	has_many :agency_categories
	has_many :categories, through: :agency_categories
	validates :name, presence: true
  #attr_accessor :full_address, :latitude, :longitude
  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.full_address.present? and obj.address_changed? }



  def self.search(search)
    where("name LIKE ? OR address LIKE ? OR zipcode LIKE ? OR state LIKE ? OR city LIKE ?", "%#{search}", "%#{search}", "%#{search}", "%#{search}", "%#{search}")
  end

  def full_address
    [address, city, state, zipcode].compact.join(',')
  end
end