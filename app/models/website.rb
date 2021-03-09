class Website < ApplicationRecord
  belongs_to :agency
  belongs_to :website_type

  validates :agency_id, presence: true
  validates :website_type_id, presence: true
  validates :url, uniqueness: { scope: [:agency_id, :website_type_id],
    message: "should have different agency and website type" }

  before_save :verify_url

  def verify_url
    unless url.nil?
      if url =~/http/

      else
        self.url = 'http://' + url
      end
    end
  end

  def self.map
    return @ret if @ret
    @ret = Hash.new{|h,k| h[k] = {} }
    all.each do |website| 
      @ret[website.agency_id][website.website_type.name] = website.url
    end
    return @ret
  end

end
