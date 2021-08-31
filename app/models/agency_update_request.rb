class AgencyUpdateRequest < ApplicationRecord
  belongs_to :agency
  validates :name, :submitted_by, :submitter_email, presence: true

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
end
