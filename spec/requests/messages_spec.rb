require 'rails_helper'

RSpec.describe 'Messages API', type: :request do
  let!(:message) { create_list :message, 2 }
  let!(:message1) { create_list :message, 5, posted: false }

  describe "GET /messages" do
    before { get '/api/v1/messages' }

    it "returns messages" do
      expect(json).not_to be_empty
      expect(json.size).to be(2)
      expect(json[0]['title']['en']).to eq('Severe Storms Threats!')
      expect(json[0]['title']['es']).to eq('Amenazas de tormentas severas!')
      expect(json[0]['posted']).to be_truthy
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /messages with params posted" do
    before { get '/api/v1/messages', params: { posted: false } }

    it "returns messages" do
      expect(json).not_to be_empty
      expect(json.size).to be(5)
      expect(json[0]['title']['en']).to eq('Severe Storms Threats!')
      expect(json[0]['title']['es']).to eq('Amenazas de tormentas severas!')
      expect(json[0]['posted']).to be_falsy
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

end
