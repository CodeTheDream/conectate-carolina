class Api::V1::MessagesController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    posted_messages = Message.posted
    unposted_messages = Message.unposted
    @messages = posted_messages.or(unposted_messages).order(posted_at: :desc)

    result = @messages.map do |msg|
      {
        id: msg.id,
        title: { en: msg.title, es: msg.titulo },
        body:  { en: msg.body,  es: msg.cuerpo },
        message_type: msg.message_type,
        updated_at: msg.updated_at,
        posted_at: msg.posted_at
      }
    end

    render json: result
  end

  def create
    device = Device.find_by_token(params[:device_message][:token]) if params[:device_message][:token].present?
    if device
      @device_message = DeviceMessage.find_by(device_id: device.id, message_id: params[:device_message][:message_id])
      modified_params = device_message_params
      modified_params[:device_id] = device.id
      modified_params[:status] = "opened"
      @device_message = DeviceMessage.create!(modified_params) if @device_message.nil?
      json_response(@device_message, :created)
    else
      render json: { error: 'Device not found.' }
    end
  end

  private
    def device_message_params
      params.require(:device_message).permit(:message_id, :token, :device_id)
    end
end
