class Api::V1::MessagesController < ApplicationController

  def index
    @messages = Message.posted.order(updated_at: :desc)

    result = @messages.map do |msg|
      {
        id: msg.id,
        title: { en: msg.title, es: msg.titulo },
        body:  { en: msg.body,  es: msg.cuerpo },
        message_type: msg.message_type,
        updated_at: msg.updated_at
      }
    end

    render json: result
  end
end
