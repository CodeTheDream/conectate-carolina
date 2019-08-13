require 'rails_helper'

RSpec.describe 'Devices API', type: :request do

  # Test suite for POST /todos
 describe 'POST /devices' do
   # valid payload
   let(:valid_attributes) { { token: 'bunch of strings' } }

   context 'when the request is valid' do
     before { post '/api/v1/devices', params: valid_attributes }

     it 'creates a device' do
       expect(json['token']).to eq('bunch of strings')
     end

     it 'returns status code 201' do
       expect(response).to have_http_status(201)
     end

   end

   context 'when the request is invalid' do
     before { post '/api/v1/devices', params: { token: ' ' } }

     it 'returns status code 422' do
       expect(response).to have_http_status(422)
     end

     it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Token can't be blank/)
      end
   end
 end
end
