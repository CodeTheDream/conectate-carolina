class Api::V1::AgenciesController < ApplicationController
  def index
    #list of agencies based on 'category_id'
    category_id = params[:category_id]
    @agencies = Agency.includes(:agency_categories).where(agency_categories: { category_id: category_id })
    render json: @agencies
  end

end
