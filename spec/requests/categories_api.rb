require "rails_helper"

 RSpec.describe "Categories API", type: :request do
    let!(:category) { create_list(:categories_api, 10) }

  describe 'GET /categories' do
    before { get '/api/v1/categories' }

    it 'returns categories' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end 
    
end