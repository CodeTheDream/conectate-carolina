class AgencyUpdateRequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @agency_update_requests = AgencyUpdateRequest.all
  end
end
