require 'rails_helper'

RSpec.describe AgencyCategory, type: :model do
  describe "Ownership" do
    it { should belong_to(:agency) }
    it { should belong_to(:category) }
  end
end
