class Website < ApplicationRecord
  belongs_to :agency
  belongs_to :website_type

  validates :agency_id, presence: true
  validates :website_type_id, presence: true
end
