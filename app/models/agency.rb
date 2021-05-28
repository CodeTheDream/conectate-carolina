class Agency < ApplicationRecord
  require 'csv'
  has_many :websites, dependent: :destroy
  accepts_nested_attributes_for :websites
  has_many :agency_categories
  has_many :categories, through: :agency_categories
  # validate :update_with_geocoded_locations
  validates :name, presence: true, uniqueness: { scope: [:address, :city, :state, :zipcode],
    message: "should have different address" }

  geocoded_by :full_address
  after_validation :geocode, if: ->(obj) { obj.full_address.present? && obj.address_changed? }
  include PgSearch::Model

  pg_search_scope :search_name, against: %i[name address state city zipcode county description descripcion],
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
    errors = []
    CSV.foreach(file.path, headers: true) do |row|
      hash = row.to_hash
      next if hash.empty?
      @updated = Agency.find_by(name:hash["name"], address:hash["address"], city:hash["city"], state:hash["state"], zipcode:hash["zipcode"])
        if @updated
          @updated.update(nombre: hash["nombre"],
                          county: hash["county"],
                          contact: hash["contact"],
                          email: hash["email"],
                          phone: hash["phone"],
                          mobile_phone: hash["mobile_phone"],
                          description: hash["description"],
                          descripcion: hash["descripcion"])
          if @updated.valid? && @updated.save
            list.push @updated
          else
            errors.push(@updated)
          end
        else
          @created = Agency.new(name:hash["name"], nombre: hash["nombre"],
                                  address:hash["address"], city:hash["city"],
                                  state:hash["state"], zipcode:hash["zipcode"], county: hash["county"],
                                  contact: hash["contact"],email: hash["email"],
                                  phone: hash["phone"], mobile_phone: hash["mobile_phone"], description: hash["description"],
                                  descripcion: hash["descripcion"])

          if @created.valid? && @created.save
            list.push @created
          else
            errors.push(@agency)
            next
          end
        end



      # Agency and Facebook urls
      website_type1 = WebsiteType.find_by(name: "Website")
      website_type2 = WebsiteType.find_by(name: "Facebook")
      if @agency && hash["agency_url"].present?
        website = @agency.websites.find_by(url: 'http://' + hash["agency_url"], website_type: website_type1)
        if website
          website.update(url: hash["agency_url"])
        else
          website = @agency.websites.create(url: 'http://' + hash["agency_url"], website_type: website_type1)
        end
      end
      if @agency && hash["facebook_url"].present?
        facebook = @agency.websites.find_by(url: 'http://' + hash["facebook_url"], website_type: website_type2)
        if facebook
          facebook.update(url: hash["facebook_url"])
        else
          facebook = @agency.websites.create(url: 'http://' + hash["facebook_url"], website_type: website_type2)
        end
      end

      # Category
      if @agency && hash["category"].present?
        category = Category.find_by(name: hash["category"])
      end
      if category
        category.update(categoria: hash["categoria"], fa_name: hash["icon"])
      else
        category = Category.create(name: hash["category"], categoria: hash["categoria"], fa_name: hash["icon"])
      end
      if @agency && category
        AgencyCategory.where(agency_id: @agency.id, category_id: category.id).first_or_create
      end
    end
    return list, errors
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
      nombre: self.nombre,
      address: self.address,
      city: self.city,
      state: self.state,
      zipcode: self.zipcode,
      county: self.county,
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

  def update_with_geocoded_locations
    if address.present? && city.present? && state.present? && zipcode.present?
      result = Geocoder.search(self.full_address)
      if result.length != 0 || result.first.data["partial_match"].nil?
        # Street number
        street_number = (result.first.data["address_components"].select { |address_hash| address_hash["types"] == ["street_number"]}).first
        if !street_number.nil?
          street_num = street_number["long_name"]
        else
          errors[:base] << "The street number could not be found."
        end
        # Street name
        route = (result.first.data["address_components"].select { |address_hash| address_hash["types"] == ["route"]}).first
        if !route.nil?
          street_name = route["short_name"]
        else
          errors[:base] << "The street name could not be found."
        end
        self.address = "#{street_num} #{street_name}" unless street_num.nil? && street_name.nil?

        # Suite number
        suite_number = (result.first.data["address_components"].select { |address_hash| address_hash["types"] == ["subpremise"]}).first
        if !suite_number.nil?
          self.address = self.address + " #" + suite_number["long_name"]
        end

        # City
        city = (result.first.data["address_components"].select { |address_hash| address_hash["types"] == ["locality", "political"]}).first
        city = (result.first.data["address_components"].select { |address_hash| address_hash["types"] == ["neighborhood", "political"]}).first if city.nil?
        if !city.nil?
          self.city = city["long_name"]
        else
          errors[:base] << "The city could not be found."
        end

        # State
        state = (result.first.data["address_components"].select { |address_hash| address_hash["types"] == ["administrative_area_level_1", "political"]}).first
        if !state.nil?
          self.state = state["short_name"]
        else
          errors[:base] << "The state could not be found."
        end
        # Zip code
        zipcode = (result.first.data["address_components"].select { |address_hash| address_hash["types"] == ["postal_code"]}).first
        if !zipcode.nil?
          self.zipcode = zipcode["long_name"]
        else
          errors[:base] << "The zip code could not be found."
        end
      end
    end
  end
end
