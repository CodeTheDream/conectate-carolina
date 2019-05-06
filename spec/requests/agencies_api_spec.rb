require 'rails_helper'

RSpec.describe 'Agencies API', type: :request do
  let!(:website_type) { create(:website_type) }
  let!(:agency) {create_list(:agency_with_categories_and_websites, 10, website_type: website_type) }

  describe 'GET /agencies' do
    before { get '/api/v1/agencies' }

    it 'returns agencies along with categories and websites' do
      # Note `json` is custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

  end
end
