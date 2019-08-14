class Message < ApplicationRecord
  validates :title, :body, :message_type, :titulo, :cuerpo, presence: true

  # default_scope { order(created_at: :desc) }
  scope :posted, -> { where(posted: true) }
  scope :unposted, -> { where(posted: false) }

end
