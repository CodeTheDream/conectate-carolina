class AgenciesController < ApplicationController
# <<<<<<< HEAD

	def index
  	if params[:search]
    	@agencies = Agency.search(params[:search])
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
			flash[:notice] = t 'flash_notice.succes'
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
			flash[:notice] = t 'flash_notice.update'
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
		params.require(:agency).permit(:name, :address, :city, :state, :zipcode)
	end
# =======
#   
#   def index
#   @agencies = Agency.all
#   end
# 
#   def show
#     @agency = Agency.find params[:id]
#   end
# 
#   def new
#   end
# 
#   def create
#     @agency = Agency.new agency_params
#     if @agency.save
#       flash[:notice] = "Succesfully created an organization"
#       redirect_to @agency
#     else
#       render 'new'
#     end
#   end
# 
#   def edit
#     @agency = Agency.find(params[:id])
#   end
# 
#   def update
#     @agency = Agency.find(params[:id])
#     if @agency.update_attributes(agency_params)
#       redirect_to @agency
#     else
#       render 'edit'
#     end
#   end
# 
#   def destroy
#     Agency.find(params[:id]).destroy
#     flash[:notice] = "Succesfully deleted."
#     redirect_to new_agency_url
#   end
# 
#   private
#     def agency_params
#       params.require(:agency).permit :name, :address, :city, :state, :zip_code
#     end
# >>>>>>> UIBranch
end
