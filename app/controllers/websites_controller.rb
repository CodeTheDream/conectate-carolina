class WebsitesController < ApplicationController
  
  def new
  	@website = Website.new
    @website = agencies.new
  end

  def create
  	@website = agency_url.websites.build(website_params)
  	if @website.save
  		flash[:success] = "website added to the organization!"
  		redirect_to @agency
  	else
  		render 'new'
    end
  end
  
  def show
  	@website = Website.find(params[:id])
    @website_agencies = @website.agencies.all
  end

  def edit
    @website = Website.find(params[:id])

  end

  def destroy
    @website = Website.find(params[:id])
    @website.destroy
    flash[:notice] = t 'flash_notice.delete'
    redirect_to new_category_url
  end

  private
  # We will need to add the facebook, twitter, and insta as params once we have full implementation of this.
  	def website_params
  		params.require(:website).permit(:socialmedia)
  	end
end
