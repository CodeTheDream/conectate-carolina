class Website < ApplicationRecord
  belongs_to :agency
  validates :agency_id, presence: true
  belongs_to :website_type
  validates :name, presence: true
end
