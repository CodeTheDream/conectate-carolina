class Message < ApplicationRecord
  validates :title, :body, :message_type, :titulo, :cuerpo, presence: true

  # default_scope { order(created_at: :desc) }
  scope :posted, -> { where.not(posted: false, posted_at: nil) }
  scope :unposted, -> { where.not(posted: true, posted_at: nil) }

end
