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
      if ag_params["status"] == "approved"
        @agency = Agency.find(@agency_update_request.agency_id)
        @agency.update(@agency_update_request.attributes_from_keys(:name,
                                                                  :nombre,
                                                                  :address,
                                                                  :city,
                                                                  :state,
                                                                  :zipcode,
                                                                  :county,
                                                                  :latitude,
                                                                  :longitude,
                                                                  :contact,
                                                                  :phone,
                                                                  :description,
                                                                  :email,
                                                                  :descripcion,
                                                                  :mobile_phone
                                                                  ))
        flash.notice = (t'flash_notice.approve-success')
        redirect_to agency_path(@agency)
      elsif ag_params["status"] == "rejected"
        flash.alert = (t'flash_notice.reject-success')
        redirect_to agency_update_requests_path
      else
        flash.notice = (t'flash_notice.save-success')
        redirect_to (request.referrer || agency_update_requests_url)
      end
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
