class FaqsController < ApplicationController

  def new
        @question = Faq.new
    end

    def index
        @question = Faq.all
    end

    def create
        @question = Faq.new(faq_params)
        if @question.save
            flash[:success] = "Question Saved"
        else
            flash[:error] = "Question not saved"
        end
    end

    def edit
        @question = Faq.find(params[:id])
    end

    def update
        @question = Faq.find(params[:id])
        if @question.update_attributes(item_params)
            flash[:success] = "Question Succesfully updated"
            redirect_to '#'
        else
            flash[:error] = "Question not saved"
        end
    end

    def destroy
        @question = Faq.find(params[:id])
        if @question.destroy
            flash[:success] = "Question Deleted"
        else
            flash[:error] = "Error deleting the quesion"
        end
    end


    private
    def faq_params
        params.require(:faq).permit(:question, :answer)
    end
end
