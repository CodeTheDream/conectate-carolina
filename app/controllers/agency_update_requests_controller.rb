class AgencyUpdateRequestsController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :set_agency, only: [:new, :create]
  before_action :set_agency_update_request, only: [:edit, :update]

  def index
    @agency_update_requests = AgencyUpdateRequest.where(status: "submitted")
  end

  def new
    @agency_update_request = @agency.agency_update_requests.new
  end

  def create
    @agency_update_request = @agency.agency_update_requests.new(ag_params)
    if @agency_update_request.save
      flash.notice = (t'flash_notice.update-success')
      redirect_to @agency
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @agency_update_request.update(ag_params)
      redirect_to edit_agency_update_request_path
      return
    else
      render 'edit'
    end
  end

  private

  def set_agency
    @agency = Agency.find(params[:agency_id])
  end

  def set_agency_update_request
    @agency_update_request = AgencyUpdateRequest.find(params[:id])
  end

  def ag_params
    params.require(:agency_update_request).permit(:name,
                                    :nombre,
                                    :address,
                                    :city,
                                    :state,
                                    :zipcode,
                                    :county,
                                    :contact,
                                    :phone,
                                    :mobile_phone,
                                    :status,
                                    :description,
                                    :descripcion,
                                    :email)
  end
end
