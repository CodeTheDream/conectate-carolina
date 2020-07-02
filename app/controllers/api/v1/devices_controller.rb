class Api::V1::DevicesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update]

  # POST /todos
  def create
    @device = Device.find_by(token: params[:device][:token])

    @device = Device.create!(device_params) if @device.nil?
    json_response(@device, :created)
  end

    # PUT /devices/:id
  def update
    @device = Device.find_by(token: params[:device][:token])

    if @device.update(selected_lang: params[:device][:selected_lang])
      render json: {id: @device.id, success: true, status: status, selected_lang: @device.selected_lang}
    else
      render json: { error: { message: 'could not update' } }, status: 400
    end

  end


  private
    def device_params
     params.require(:device).permit(:token, :selected_lang)
    end
end
