class WebsiteTypesController < ApplicationController

class WebsitesController < ApplicationController
  
  def new
  	@website_type = WebsiteType.new
    @website_type = agencies.new
  end

  def create
  	@website_type = agency_url.website_types.build(website_type_params)
  	if @website_type.save
  		flash[:success] = "website added to the organization!"
  		redirect_to @agency
  	else
  		render 'new'
    end
  end
  
  def show
  	@website_type = WebsiteType.find(params[:id])
    @website_type_agencies = @website_type.agencies.all
  end

  def edit
    @website_type = WebsiteType.find(params[:id])

  end

  def destroy
    @website_type = WebsiteType.find(params[:id])
    @website_type.destroy
    flash[:notice] = t 'flash_notice.delete'
    redirect_to new_category_url
  end

  private
  # We will need to add the facebook, twitter, and insta as params once we have full implementation of this.
  	def website_type_params
  		params.require(:website_type).permit(:name, :icon, :url)
  	end
end

end