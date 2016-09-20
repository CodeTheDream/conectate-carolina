class SearchController < ApplicationController
  def search
    if params[:q].nil?
      @agencies = []
    else
      @agencies = Agency.search( params[:q])
    end
    # unless params[:query].blank? 
    #   @agencies = Agency.search( params[:query] )
    # end
  end
end
