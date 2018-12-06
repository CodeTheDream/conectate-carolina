require 'rails_helper'

RSpec.describe Agency, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

  describe "Associations" do
    it { should have_many(:agency_categories) }
    it { should have_many(:websites).dependent(:destroy) }
    it { should have_many(:categories).through(:agency_categories) }
  end

  describe "Attributes" do
    it { should accept_nested_attributes_for(:websites) }
  end

  describe ".upcase_fields" do

    state1 = "nc"
    state2 = "NC"
    name = "Test Agency"

    context "State is entered lowercase" do
      it "should be converted to uppercase" do
        agency = build :agency, name: name, state: state1
        agency.upcase_fields
        agency.save
        agency.state.should eq state2
      end
    end
  end

  describe ".full_address" do
    name = "Test Agency"
    address = "123 Main St."
    city = "Durham"
    state = "NC"
    zipcode = "27701"
    complete_address = "123 Main St., Durham, NC, 27701"

    context "Address is entered on separate lines" do
      it "should be joined into one address line" do
        agency = build :agency, name: name, address: address, city: city, state: state, zipcode: zipcode
        agency.full_address
        agency.save
        agency.full_address.should eq complete_address
      end
    end
  end

  describe "Geocoder module" do
    it 'geocodes addresses' do
      mock_geocoding!
      agency = Agency.new(address: '201 W. Main St', city: 'Durham', state: 'NC', zipcode: '27701')
      agency.save
      expect(agency.latitude).to eq 35.99558
      expect(agency.longitude).to eq(-78.90216910000001)
    end

    def mock_geocoding!(options = {})
      options.reverse_merge!(
        address: '201 W. Main St, Durham, 27701',
        coordinates: [35.99558, -78.90216910000001],
        state: 'NC',
        country: 'US'
      )

      MockResult.new.tap do |result|
        options.each do |prop, val|
          allow(result).to receive(prop).and_return(val)
        end
        allow(Geocoder).to receive(:search).and_return([result])
      end
    end

    class MockResult < ::Geocoder::Result::Base
      def initialize(data = [])
        super(data)
      end
    end
  end
end
