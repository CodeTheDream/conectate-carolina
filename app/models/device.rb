class Device < ApplicationRecord
  # Validation
  validates :token, presence: true
  has_many :device_messages
  has_many :messages, through: :device_messages
end
