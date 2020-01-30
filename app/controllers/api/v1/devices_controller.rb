class Api::V1::DevicesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @device = Device.find_by(token: params[:device][:token])

    if @device
      @device = Device.create(device_params)
      json_response(@device, :created)
    else
      @device.update(device_params)
      json_response(@device, :updated)
    end
  end


  private
    def device_params
     params.require(:device).permit(:token, :selected_lang)
    end
end
