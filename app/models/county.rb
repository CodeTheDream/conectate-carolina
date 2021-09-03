class County < ApplicationRecord
  has_many :agency_counties
  has_many :agencies, through: :agency_counties
  validates :name, :state, presence: true
  validates :name, uniqueness: { scope: :state, message: "should be unique to a state" }
end
