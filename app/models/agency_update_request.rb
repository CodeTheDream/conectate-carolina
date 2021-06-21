class AgencyUpdateRequest < ApplicationRecord
  belongs_to :agency

  def attributes_from_keys(*keys)
    keys.inject({}) do |hash_to_return, key|
      hash_to_return.merge(key => send(key))
    end
  end
end
