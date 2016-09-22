class AgenciesController < ApplicationController

	def index
	end

	def show
		@agency = Agency.find(params[:id])
	end

	def new
		@agency = Agency.new
	end

	def create 
		@agency = Agency.new(agency_params)
		if @agency.save
			flash[:notice] = "Successfully created a agency."
			redirect_to @agency
		else
			render 'new'
		end
	end

	def agency_params
		params.require(:agency).permit(:name, :address, :city, :state, :zipcode)
	end
end
