class Api::V1::MessagesController < ApplicationController

  def index
    @messages = Message.posted.order(updated_at: :desc)
    if params[:posted].present? && !ActiveModel::Type::Boolean.new.cast(params[:posted])
      @messages = Message.unposted.order(updated_at: :desc)
    end

    result = @messages.map do |msg|
      { id: msg.id,
        title: { en: msg.title, es: msg.titulo },
        body:  { en: msg.body,  es: msg.cuerpo },
        posted: msg.posted,
        message_type: msg.message_type,
        updated_at: msg.updated_at
      }
    end

    render json: result
  end
end
