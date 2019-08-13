class Device < ApplicationRecord
  # Validation
  validates :token, presence: true
end
