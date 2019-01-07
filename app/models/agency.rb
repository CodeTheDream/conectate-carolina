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
  include PgSearch

  pg_search_scope :search_name, against: %i[name address state city zipcode description descripcion],
                                associated_against: { categories: %i[name categoria] },
                                ignoring: :accents

  def upcase_fields
    state.upcase!
  end

  def full_address
    [address, city, state, zipcode].compact.join(', ')
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      hash = row.to_hash
      next if hash.empty?
      agency = Agency.find_or_create_by(
                name:        hash["name"],
                address:     hash["address"],
                city:        hash["city"],
                state:       hash["state"],
                zipcode:     hash["zipcode"]
              )
      agency.update_attributes( contact:     hash["contact"],
                                email:       hash["email"],
                                phone:       hash["phone"],
                                description: hash["description"],
                                descripcion: hash["descripcion"]
                                )

      next unless agency.save

      @agency_website = agency.websites.find_or_create_by(
                          url:          hash["agency_url"],
                          website_type: WebsiteType.find_by(name: "Agency URL")
                        )

      @facebook_website = agency.websites.find_or_create_by(
                            url:          hash["facebook_url"],
                            website_type: WebsiteType.find_by(name: "Facebook URL")
                          )

      @category = agency.categories.find_or_create_by(
                    name:      hash["category"],
                    categoria: hash["categoria"],
                    fa_name:   hash["fa_name"]
                  )
    end
  end
end
