class AgencyUpdateRequestsController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :set_agency, only: [:new, :create]

  def index
    @agency_update_requests = AgencyUpdateRequest.all
  end

  def new
    @agency_update_request = @agency.agency_update_requests.new
  end

  def create
    @agency_update_request = @agency.agency_update_requests.new(ag_params)
    if @agency_update_request.save
      flash.notice = (t'flash_notice.success')
      redirect_to @agency_update_request
    else
      render 'new'
    end
  end

  private

  def set_agency
    @agency = Agency.find(params[:agency_id])
  end

  def ag_params
    params.require(:require).permit(:name,
                                    :nombre,
                                    :address,
                                    :city,
                                    :state,
                                    :zipcode,
                                    :county,
                                    :contact,
                                    :phone,
                                    :mobile_phone,
                                    :description,
                                    :descripcion,
                                    :email)
  end
end
