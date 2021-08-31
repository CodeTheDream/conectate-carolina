class County < ApplicationRecord
  has_many :agency_counties
  has_many :agencies, through: :agency_counties
  validates :name, :state, presence: true
end
