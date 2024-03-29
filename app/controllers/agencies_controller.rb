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
    	@agencies
   	end

    if params["county"].present?
      str = params["county"]
      parsed_county = JSON.parse(str).first["value"]
      county = County.find_by(name: parsed_county)
      @agencies = Agency.joins(:agency_counties).where({ "agency_counties.county_id" => county.id })
      if params[:search].present?
        @agencies = @agencies.search_name(params[:search])
      else
        @agencies
      end
    end

    # This code below is for the csv downloads.
    @headers = %w(name nombre address city state zipcode county contact phone description email descripcion mobile_phone category categoria icon agency_url facebook_url)
    @website_type = WebsiteType.find_by(name: "Website")
    @facebook_type = WebsiteType.find_by(name: "Facebook")
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
    if @agency.valid? && @agency.save
      if params[:all_counties]
        County.all.each {|county| @agency.agency_counties.find_or_create_by(county_id: county.id)}
      end
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
    if @agency.update(agency_params)
      if params[:all_counties]
        County.all.each {|county| @agency.agency_counties.find_or_create_by(county_id: county.id)}
      end
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
      @agencies, @errors = Agency.import(params[:file])
    else
      redirect_to new_agency_path, alert: "You need to choose a file first!"
    end
  end

  private

  def agency_params
    params.require(:agency).permit(:name, :nombre, :address, :city, :state, :zipcode, :county,
                                   :contact, :phone, :mobile_phone, :description, :descripcion, :email, :name, :website, :website_type,
                                   category_ids: [], county_ids: [])
  end

end
