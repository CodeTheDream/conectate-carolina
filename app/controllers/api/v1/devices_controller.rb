class Api::V1::DevicesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @device = Device.find_by(token: params[:device][:token])

    if @device
      @device.update(selected_lang: params[:device][:selected_lang])
      json_response(@device, :updated)
    else
      @device = Device.create(device_params)
      json_response(@device, :created)
    end
  end


  private
    def device_params
     params.require(:device).permit(:token, :selected_lang)
    end
end
