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
    device = Device.find_by_token(params[:device_message][:token])
    @device_message = device.device_messages.find_by(message_id: params[:device_message][:message_id])
    @device_message = device.device_messages.create!(device_message_params) if @device_message.nil?
    @device_message.update(status: 'opened')
    json_response(@device_message, :created)
  end

  private
    def device_message_params
      params.require(:device_message).permit(:message_id, :ticket_id, error_messages: {})
    end
end
