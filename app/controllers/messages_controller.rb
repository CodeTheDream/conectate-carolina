class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
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

  def show
    authorize @message
  end

  def edit
    authorize @message
  end

  def update
    authorize @message
    if @message.update_attributes(message_params)
      flash[:notice] = "Message updated."
      redirect_to @message
    else
      render 'edit'
    end
  end

  def destroy
    authorize @message
  end
  private

    def message_params
      params.require(:message).permit(:title, :body)
    end

    def set_message
      @message = Message.find(params[:id])
    end
end
