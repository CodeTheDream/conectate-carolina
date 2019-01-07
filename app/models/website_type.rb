class WebsiteType < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :icon,
    message: "should have different icon" }
end
