require 'rails_helper'

RSpec.describe Website, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:agency_id) }
    it { should validate_presence_of(:website_type_id) }
  end

  describe "Associations" do
    it { should belong_to(:agency) }
    it { should belong_to(:website_type) }
  end

  describe ".verify_url" do
    url1 = "http://google.com"
    url2 = "google.com"

    before do
      @agency = Agency.create(name: "Test Agency")
      @website_type = WebsiteType.create(name: "Test Website", icon: "123")
    end

    context "url contains http" do
      it "should not change url" do
        website = build :website, agency: @agency, website_type: @website_type, url: url1
        website.save
        website.verify_url
        website.url.should eq url1
      end
    end


    context "url does not contain http" do
      it "should add http to url" do
        website = build :website, agency: @agency, website_type: @website_type, url: url2
        website.save
        website.url.should eq url1
      end
    end
  end
end
