class WebsiteTypesController < ApplicationController

  def new
  	@website_type = WebsiteType.new
  end

  def create
  	@website_type = WebsiteType.new(website_type_params)
  	if @website_type.save
  		flash[:success] = "website added to the organization!"
  		redirect_to(root_path)
  	else
  		render 'new'
    end
  end

  def show
  	@website_type = WebsiteType.find(params[:id])
  end

  def edit
    @website_type = WebsiteType.find(params[:id])
  end

  def destroy
    @website_type = WebsiteType.find(params[:id])
    @website_type.destroy
    flash[:notice] = t 'flash_notice.delete'
    redirect_to(root_path)
  end

  private
  	def website_type_params
  		params.require(:website_type).permit(:name, :icon)
  	end
end
