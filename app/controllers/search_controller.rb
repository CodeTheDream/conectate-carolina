class SearchController < ApplicationController

  def index
    if params[:query].present?
      agencies = Agency.search_name(params[:query])
    else
      @agencies = Agency.all
    end
  end

 	def search
 		if params[:location].present?
 			@gencies = Agency.near(params[:location])
 		else
 			@agencies = Agency.all
 		end
		#Code hash send info of all agencies to the view to get converted to JSON
		@hash = Gmaps4rails.build_markers(@agencies) do |agency, marker|
    	marker.lat agency.latitude
    	marker.lng agency.longitude
  		marker.infowindow agency.name
		end
	end
end
