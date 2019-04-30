class Api::V1::AgenciesController < ApplicationController
  def index
    #list of agencies based on 'category_id'
    @category = Category.find(params[:category_id])
    @agencies = Agency.search_name(@category.name)
    render json: @agencies
  end

end
