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
        flash[:notice] = "Faq Saved"
        redirect_to(faqs_path)
    else
        flash[:error] = "Faq not saved"
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
    if @faq.update(faq_params)
        flash[:notice] = "Faq updated"
        redirect_to(faqs_path)
    else
        flash[:error] = "Faq not updated"
    end
  end

  def destroy
    @faq = Faq.find(params[:id])
    authorize @faq
    if @faq.destroy
        flash[:success] = "Faq Deleted"
        redirect_to faqs_path
    else
        flash[:error] = "Error deleting the Faq"
    end
  end

  private
  def faq_params
    params.require(:faq).permit(:question, :answer, :pregunta, :respuesta)
  end
end
