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

		@hash = Gmaps4rails.build_markers(@agencies) do |agency, marker|
	  	marker.lat agency.latitude
			marker.lng agency.longitude
			marker.infowindow agency.name
		end
		@categories = Category.all
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
      marker.infowindow agency.name
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
    @agency_ids = Agency.ids
    @initial_count = Agency.count

    if params[:file].present?
      Agency.import(params[:file])
      @added_agencies = Agency.where.not(id: @agency_ids)
      @added_count = Agency.count - @initial_count
      if @added_count != 0
        flash.now[:notice] = "#{@added_count} #{'agency'.pluralize(@added_count)} added successfully!"
      else
        flash.now[:warning] = "Some or all agencies have been added already!"
      end
    else
      redirect_to new_agency_path, alert: "You need to choose a file first!"
    end
  end

  private

  def agency_params
    params.require(:agency).permit(:name, :address, :city, :state, :zipcode,
                                   :contact, :phone, :description, :descripcion, :email, :name, :website_type,
                                   category_ids: [])
  end
end
