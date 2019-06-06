class Message < ApplicationRecord
  # belongs_to :user
  default_scope { order(created_at: :desc) }

  scope :posted, -> { where(posted: true) }

end
