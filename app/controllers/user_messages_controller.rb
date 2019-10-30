class UserMessagesController < ApplicationController
  def index
    posted_messages = Message.posted
    unposted_messages = Message.unposted
    user_messages = posted_messages.or(unposted_messages)
    @user_messages = user_messages.paginate(page: params[:page], per_page: 10).order(created_at: :desc)
  end

  def show
    begin
      posted_messages = Message.posted
      unposted_messages = Message.unposted
      user_messages = posted_messages.or(unposted_messages)
      @user_message = user_messages.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash.alert = "Message not found."
      redirect_to user_messages_path
    end
  end
end
