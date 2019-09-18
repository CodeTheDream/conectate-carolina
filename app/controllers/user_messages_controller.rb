class UserMessagesController < ApplicationController
  def index
    user_messages = Message.unposted
    @user_messages = user_messages.paginate(page: params[:page], per_page: 10).order(created_at: :desc)
  end

  def show
    @user_message = Message.unposted.find(params[:id])
  end
end
