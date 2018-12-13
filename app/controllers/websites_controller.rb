class WebsitesController < ApplicationController

  def new
  	@website = Website.new
  end

  def create
  	@website = Website.new(website_params)
  	if @website.save
  		flash[:success] = "Website added to the organization!"
  		redirect_to(websites_path)
  	else
  		render 'new'
    end
  end

  def show
  	@website = Website.find(params[:id])
  end

  def edit
    @website = Website.find(params[:id])

  end

  def destroy
    @website = Website.find(params[:id])
    @website.destroy
    flash[:notice] = t 'flash_notice.delete'
    redirect_to(websites_path)
  end

  private
  	def website_params
  		params.require(:website).permit(:url, :agency_id, :website_type_id)
  	end
end
