require 'rails_helper'

RSpec.describe 'Devices API', type: :request do

   # Test suite for POST /devices
   describe 'POST /devices' do
     # valid payload
     let(:valid_attributes) { { device: { token: 'bunch of strings', selected_lang: 'es' } } }

     context 'when the request is valid' do

       it 'creates a device if not found' do
         post '/api/v1/devices', params: valid_attributes
         expect(json['token']).to eq('bunch of strings')
         expect(json['selected_lang']).to eq('es')
       end

       it 'updates device if it already exists' do
         post '/api/v1/devices', params: valid_attributes
         device = Device.first
         expect(device.token).to eq('bunch of strings')
         expect(device.selected_lang).to eq('es')
       end
     end
   end
end
