require 'rails_helper'

RSpec.describe AgencyUpdateRequest, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:submitted_by) }
    it { should validate_presence_of(:submitter_email) }
  end

  describe "Associations" do
    it { should belong_to(:agency) }
  end
end
