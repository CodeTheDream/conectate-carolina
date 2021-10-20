class AgencyUpdateRequest < ApplicationRecord
  belongs_to :agency
  before_save   :downcase_submitter_email
  validates :name, :submitted_by, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :submitter_email, presence: true, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }

  geocoded_by :full_address
  after_validation :geocode, if: ->(obj) { obj.full_address.present? && obj.address_changed? }

  def attributes_from_keys(*keys)
    keys.inject({}) do |hash_to_return, key|
      hash_to_return.merge(key => send(key))
    end
  end

  def full_address
    sub_address = [address, city, state].compact.join(', ')
    [sub_address, zipcode].compact.join(' ')
  end

  private

    # Converts email to all lower-case.
     def downcase_submitter_email
         submitter_email.downcase!
     end
end
