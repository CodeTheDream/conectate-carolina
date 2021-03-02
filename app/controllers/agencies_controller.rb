require 'rails_rinku'
require 'csv'

class AgenciesController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  after_action :verify_authorized, except: %i[show index]

  def index
    location = if params[:location].present?
                 params[:location]
               else
                 params[:coordinates]
               end
    location = 'Raleigh, NC' unless location.present?
    @agencies = Agency.near(location, 20)

    if params[:search].present?
      location = if params[:location].present?
                   params[:location]
                 else
                   params[:coordinates]
                 end
      distance = params[:distance] if params[:distance].present?
      distance = 20 unless distance.present?
      @distance = distance
      location = 'Raleigh, NC' unless location.present?
      @ag = Agency.search_name(params[:search])
      @agencies = @ag.near(location, distance)
   	else
    	@agencies = @agencies.near(location, 15)
   	end

    # This code below is for the csv downloads.
    @agency_categories = AgencyCategory.order(:agency_id)
    response_format

    # This code below is for map markers
		@hash = Gmaps4rails.build_markers(@agencies) do |agency, marker|
	  	marker.lat agency.latitude
			marker.lng agency.longitude
			marker.infowindow "<a href='/#{params[:locale]}/agencies/#{agency.id}'>#{agency.name}</a>"
		end
		@categories = Category.all
    @message = Message.posted.order(updated_at: :desc).first
	end

  def new
    @agency = Agency.new
    authorize @agency
  end

  def create
    @agency = Agency.new(agency_params)
    authorize @agency
    if @agency.save
      params[:agency][:website].each do |website_type_id, url|
        next if url.blank?
        @agency.websites.create(
          website_type_id: website_type_id,
          url: url
        )
      end
      flash[:notice] = (t'flash_notice.success')
      redirect_to @agency
    else
      render 'new'
    end
  end

  def show
    @agency = Agency.find(params[:id])
    @hash = Gmaps4rails.build_markers(@agency) do |agency, marker|
      marker.lat agency.latitude
      marker.lng agency.longitude
      marker.infowindow "<a href='https://www.google.com/maps/dir/Current+Location/#{agency.full_address}' targe='_blank'>#{agency.name}</a>"
    end
  end

  def search
    @agencies = Agency.search(params)
  end

  def edit
    @agency = Agency.find(params[:id])
    authorize @agency
  end

  def update
    @agency = Agency.find(params[:id])
    authorize @agency
    if @agency.update_attributes(agency_params)
      @agency.websites.each(&:destroy)
      params[:agency][:website].each do |website_type_id, url|
        next if url.blank?
        @agency.websites.create(
          website_type_id: website_type_id,
          url: url
        )
      end
      flash[:notice] = (t'flash_notice.update')
      redirect_to @agency
    else
      render 'edit'
    end
  end

  def destroy
    @agency = Agency.find(params[:id])
    authorize @agency
    @agency.destroy
    flash[:notice] = t 'flash_notice.delete'
    redirect_to new_agency_url
  end

  def import
    authorize Agency
    if params[:file].present?
      @agencies = Agency.import(params[:file])
      flash.now[:notice] = "#{@agencies.count} agencies uploaded successfully!"
    else
      redirect_to new_agency_path, alert: "You need to choose a file first!"
    end
  end

  private

  def agency_params
    params.require(:agency).permit(:name, :address, :city, :state, :zipcode,
                                   :contact, :phone, :mobile_phone, :description, :descripcion, :email, :name, :website, :website_type,
                                   category_ids: [])
  end
end
