class County < ApplicationRecord
  validates :name, :state, presence: true
end
