class Category < ApplicationRecord
  has_many :agency_categories
  has_many :agencies, through: :agency_categories

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates_uniqueness_of :name

  include PgSearch

end
