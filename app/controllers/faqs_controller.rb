class FaqsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  after_action  :verify_authorized, except: [:show, :index]

  def index
    @faqs = Faq.all
  end

  def show
    @faq = Faq.find(params[:id])
  end

  def new
    @faq = Faq.new
    authorize @faq
  end

  def create
    @faq = Faq.new(faq_params)
    authorize @faq
    if @faq.save
        flash[:success] = "Question Saved"
        redirect_to(faqs_path)
    else
        flash[:error] = "Question not saved"
        render('new')
    end
  end

  def edit
    @faq = Faq.find(params[:id])
    authorize @faq
  end

  def update
    @faq = Faq.find(params[:id])
    authorize @faq
    if @faq.update_attributes(faq_params)
        flash[:success] = "Question Succesfully updated"
        redirect_to(faqs_path)
    else
        flash[:error] = "Question not saved"
    end
  end

  def destroy
    @faq = Faq.find(params[:id])
    authorize @faq
    if @faq.destroy
        flash[:success] = "Question Deleted"
        redirect_to faqs_path
    else
        flash[:error] = "Error deleting the quesion"
    end
  end

  private
  def faq_params
    params.require(:faq).permit(:question, :answer, :pregunta, :respuesta)
  end
end
