class Agency < ApplicationRecord
  has_many :websites, dependent: :destroy
	has_many :agency_categories
	has_many :categories, through: :agency_categories
	validates :name, presence: true
  #attr_accessor :full_address, :latitude, :longitude
  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.full_address.present? and obj.address_changed? }

  def full_address
    [address, city, state, zipcode].compact.join(',')
  end

  def self.search(params)
    #agencies = Agency.where(category_id: params[:category].to_i)
    agencies = Agency.near(params[:location])
    agencies = agencies.where("name LIKE ? OR address LIKE ? OR city LIKE ? OR state LIKE ? OR zipcode LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
    agencies
  end

  #def self.location(location)
   # where("zipcode LIKE ? OR state LIKE ? OR city LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%" )
  #end
end