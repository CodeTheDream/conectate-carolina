class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy, :post, :unpost]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  after_action  :verify_authorized

  def index
    @messages = Message.all
    authorize @messages
  end

  def new
    @message = Message.new
    authorize @message
  end

  def create
    @message = Message.new(message_params)
    authorize @message
    if @message.save
      flash[:notice] = "Message created."
      redirect_to messages_path
    else
      render 'new'
    end
  end

  def edit
    authorize @message
  end

  def update
    authorize @message
    if @message.update_attributes(message_params)
      flash[:notice] = "Message updated."
      redirect_to messages_path
    else
      render 'edit'
    end
  end

  def destroy
    authorize @message
  end

  def post
    authorize @message
    @message.update_attributes(posted: true)
    flash[:notice] = "Message posted."
    redirect_to messages_path
  end

  def unpost
    authorize @message
    @message.update_attributes(posted: false)
    flash[:notice] = "Message unposted."
    redirect_to messages_path
  end


  private

    def message_params
      params.require(:message).permit(:title, :body, :posted, :message_type, :titulo, :cuerpo)
    end

    def set_message
      @message = Message.find(params[:id])
    end
end
