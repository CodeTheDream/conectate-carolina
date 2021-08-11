class AgencyUpdateRequest < ApplicationRecord
  belongs_to :agency
  validates :name, :submitted_by, :submitter_email, presence: true

  def attributes_from_keys(*keys)
    keys.inject({}) do |hash_to_return, key|
      hash_to_return.merge(key => send(key))
    end
  end
end
