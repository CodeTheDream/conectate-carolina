class AgencyCounty < ApplicationRecord
  belongs_to :agency
  belongs_to :county
end
