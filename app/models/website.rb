class Website < ApplicationRecord
  belongs_to :agency
  belongs_to :website_type

  validates :agency_id, presence: true
  validates :website_type_id, presence: true

  before_save :verify_url
  def verify_url
    if url =~/http/

    else
      self.url = 'http://' + url
    end
  end

end
