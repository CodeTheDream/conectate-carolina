class Website < ApplicationRecord
  belongs_to :agency
  validates :agency_id, presence: true
end
