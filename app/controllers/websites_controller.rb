class WebsitesController < ApplicationController
  
  def new
  	@website = Website.new
  end

  def create
  	@website = agency_url.websites.build(website_params)
  	if @website.save
  		flash[:success] = "website added to the organization!"
  		redirect_to @agency
  	else
  		render 'new'
  end
  
  def show
  	@website = Website.find(params[:id])
    @website_agencies = @website.agencies.all
  end

  def edit
    @website = Website.find(params[:id])

  end

  def destroy
  end

  private
  	def website_params
  		params.require(:website).permit(:socialmedia)
  	end
  end
end
