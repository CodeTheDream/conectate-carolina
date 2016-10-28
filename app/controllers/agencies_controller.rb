class AgenciesController < ApplicationController

	def index
  	if params[:search].present?
    	@agencies = Agency.near(params[:search], 20, :order => :distance)
  	else
    	@agencies = Agency.all.order("created_at DESC")
  	end
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
			flash[:notice] = (t'flash_notice.success')
			redirect_to @agency
		else
			render 'new'
		end
	end

	def edit
		@agency = Agency.find(params[:id])
	end

	def update
		@agency = Agency.find(params[:id])
		if @agency.update_attributes(agency_params)
			flash[:notice] = (t'flash_notice.update')
			redirect_to @agency
		else
			render  'edit'
		end
	end

	def destroy
		Agency.find(params[:id]).destroy
		flash[:notice] = t 'flash_notice.delete'
		redirect_to new_agency_url
	end


private
	def agency_params
		params.require(:agency).permit :name, :address, :city, :state, :zipcode
	end
end
