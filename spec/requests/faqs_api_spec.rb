require "rails_helper"

 RSpec.describe "Faqs API", type: :request do
    let!(:faq) { create_list(:faqs_api, 10) }

    describe 'GET /faqs' do
    before { get '/api/v1/faqs' }
    
    it 'returns faqs' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
 end 
    
end