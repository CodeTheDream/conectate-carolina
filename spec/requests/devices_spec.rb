require 'rails_helper'

RSpec.describe 'Devices API', type: :request do

  # Test suite for POST /devices
 describe 'POST /devices' do
   # valid payload
   let(:valid_attributes) { { device: { token: 'bunch of strings' } } }

   context 'when the request is valid' do
     before { post '/api/v1/devices', params: valid_attributes }

     it 'creates a device' do

       expect(json['token']).to eq('bunch of strings')
     end

     it 'returns status code 201' do
       expect(response).to have_http_status(201)
     end
   end

 end

end
