class Agency < ApplicationRecord
  require 'csv'
  has_many :websites, dependent: :destroy
  accepts_nested_attributes_for :websites
  has_many :agency_categories
  has_many :categories, through: :agency_categories
  validates :name, presence: true, uniqueness: { scope: [:address, :city, :state, :zipcode],
    message: "should have different address" }
  geocoded_by :full_address
  after_validation :geocode, if: ->(obj) { obj.full_address.present? && obj.address_changed? }
  include PgSearch::Model

  pg_search_scope :search_name, against: %i[name address state city zipcode description descripcion],
                                associated_against: { categories: %i[name categoria] },
                                ignoring: :accents

  def upcase_fields
    state.upcase!
  end

  def full_address
    sub_address = [address, city, state].compact.join(', ')
    [sub_address, zipcode].compact.join(' ')
  end

  def self.import(file)
    list = []
    CSV.foreach(file.path, headers: true) do |row|
      hash = row.to_hash
      next if hash.empty?
      @agency = Agency.where(name:hash["name"], address:hash["address"], city:hash["city"], state:hash["state"], zipcode:hash["zipcode"]).first_or_create do |agency|
        agency.contact = hash["contact"]
        agency.email = hash["email"]
        agency.phone = hash["phone"]
        agency.description = hash["description"]
        agency.descripcion = hash["descripcion"]
        agency.mobile_phone = hash["mobile_phone"]
      end
      list.push @agency
      # Agency and Facebook urls
      @agency.websites.where(url: 'http://' + hash["agency_url"], website_type: WebsiteType.find_by(name: "Website")).first_or_create if hash["agency_url"].present?
      @agency.websites.where(url: 'http://' + hash["facebook_url"], website_type: WebsiteType.find_by(name: "Facebook")).first_or_create if hash["facebook_url"].present?
      # Category
      category = Category.where(name: hash["category"], categoria: hash["categoria"], fa_name: hash["icon"]).first_or_create
      if @agency && category
        AgencyCategory.where(agency_id: @agency.id, category_id: category.id).first_or_create
      end
    end
    list
  end

  def new_agency_hash
    category_array = []
    website_array = []

    self.categories.each do |cat|
      category_array << { id: cat.id, name: cat.name, categoria: cat.categoria, fa_name: cat.fa_name }
    end

    self.websites.each do |web|
      website_array << { id: web.id, name: web.website_type.name, url: web.url, icon: web.website_type.icon }
    end

    { id: self.id,
      name: self.name,
      address: self.address,
      city: self.city,
      state: self.state,
      zipcode: self.zipcode,
      contact: self.contact,
      email: self.email,
      phone: self.phone,
      mobile_phone: self.phone,
      latitude: self.latitude,
      longitude: self.longitude,
      description: self.description,
      descripcion: self.descripcion,
      categories: category_array,
      websites: website_array
    }
  end
end
