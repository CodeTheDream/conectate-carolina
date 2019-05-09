require 'rails_helper'

RSpec.describe 'Agencies API', type: :request do
  let!(:website_type) {create(:website_type)}
  let!(:category) { create(:category1) }
  let!(:agency10s) { create_list(:agency_with_categories_and_websites, 10, website_type: website_type,
                      updated_at: '2019-01-10') }
  let!(:agency2) { create :agency_with_categories_and_websites, website_type: website_type,
                    updated_at: '2019-01-02', category_ids: category.id, name: "CtDurhamNC",
                    address: "Durham, NC" }

  describe 'GET /agencies' do
    before {get '/api/v1/agencies'}

    it 'returns agencies along with categories and websites' do
      # Note `json` is custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(11)
      expect(json[0]['categories'].size).to eq(5)
      expect(json[0]['websites'].size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /agencies with `updated_since`' do
    before { get '/api/v1/agencies', params: { updated_since: '2019-01-05 00:00:00 -0000' } }

    it 'returns agencies updated since a particular date and time' do
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /agencies with `category_id`' do
    before { get '/api/v1/agencies', params: { category_id: category.id } }

    it 'returns agencies based on the `category_id` params' do
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /agencies with `search`' do
    before { get '/api/v1/agencies', params: { search: "CtDurhamNC", address: "Durham, NC", coordinates: "#{agency2.latitude}, #{agency2.longitude}" } }

    it 'returns agencies based on the `search`, `address`, & `distance` params' do
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
