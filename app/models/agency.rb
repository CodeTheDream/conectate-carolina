class Agency < ApplicationRecord
  has_many :websites, dependent: :destroy
  accepts_nested_attributes_for :websites
	has_many :agency_categories
	has_many :categories, through: :agency_categories
	validates :name, presence: true
  #attr_accessor :full_address, :latitude, :longitude
  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.full_address.present? and obj.address_changed? }

  # Ask ramiro, this upcase_fields method raises an error when seeding saf info
  # before_save :upcase_fields
  # method to convert state to all uppercase and save in database -JR
  def upcase_fields
    self.state.upcase!
  end

  def full_address
    [address, city, state, zipcode].compact.join(', ')
  end


  #Method not finished
  def self.search(params)
    if params[:location].present?
      location = params[:location]
    else
      location = params[:coordinates]
    end
    location = "Raleigh NC" if not location.present?
    agencies = Agency.near(location, 50)
    if params[:category].present?
      agencies = agencies.where(category_id: params[:category].to_i)
    end
    if params[:search].present?
      # postgress better way to write this query, active record search methods. case sensitive
      # The LIKE syntax is used for MySQL, but if you are deploying to Heroku or
      # another platform that uses PostgreSQL use the ILIKE syntax instead.
      # agencies = agencies.where("name LIKE ? OR address LIKE ? OR city LIKE ? OR state LIKE ? OR zipcode LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
      agency_arel = Agency.arel_table
      category_arel = Category.arel_table

      query_string = "%#{params[:search]}%"
      agency_param_matches_string =  ->(param){
        agency_arel[param].matches(query_string)
      }
      category_param_matches_string =  ->(param){
        category_arel[param].matches(query_string)
      }
      agencies = agencies.where(agency_param_matches_string.(:name).
                                or(agency_param_matches_string.(:address)).
                                or(agency_param_matches_string.(:state)).
                                or(agency_param_matches_string.(:city)).
                                or(agency_param_matches_string.(:zipcode)).
                                or(category_param_matches_string.(:name)).
                                or(category_param_matches_string.(:categoria)))

      agencies = agencies.joins(:categories)
    end
    agencies
  end
end
