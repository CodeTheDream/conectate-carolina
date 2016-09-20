class AgenciesController < ApplicationController
  def index
  @agencies = Agency.all
  end

  def show
    @agency = Agency.find params[:id]
  end

  def new
  end

  def create
    @agency = Agency.new agency_params
    if @agency.save
      redirect_to @agency
    else
      render 'new'
    end
  end

  private
    def agency_params
      params.require(:agency).permit :name, :address, :city
    end
end
