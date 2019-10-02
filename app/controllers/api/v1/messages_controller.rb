class Api::V1::MessagesController < ApplicationController

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
end
