class AgencyUpdateRequestsController < ApplicationController
  def index
    @agency_update_requests = AgencyUpdateRequest.all
  end
end
