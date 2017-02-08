class Agency < ApplicationRecord
  has_many :websites, dependent: :destroy
  accepts_nested_attributes_for :websites
	has_many :agency_categories
	has_many :categories, through: :agency_categories
	validates :name, presence: true
  #attr_accessor :full_address, :latitude, :longitude
  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.full_address.present? and obj.address_changed? }


  before_save :upcase_fields
  # method to convert state to all uppercase and save in database -JR
  def upcase_fields
    self.state.upcase!
  end

  def full_address
    [address, city, state, zipcode].compact.join(', ')
  end


  #Method not finished
  def self.search(params)
    params[:location] = "Raleigh, NC" if not params[:location].present?
    agencies = Agency.near(params[:location], 50)
    if params[:category].present?
      agencies = agencies.where(category_id: params[:category].to_i)
    end
    if params[:search].present?
      agencies = agencies.where("name LIKE ? OR address LIKE ? OR city LIKE ? OR state LIKE ? OR zipcode LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
    end
    agencies
  end
end
