class SearchController < ApplicationController
  
  def index
    if params[:location].present?
     @agencies = Agency.near(params[:location], params[:distance] || 10, order: :distance)
    else
      @agencies = Agency.all
    end
  end
end
