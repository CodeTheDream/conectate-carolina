class Api::V1::AgenciesController < ApplicationController
  def index
    agencies = Agency.order(:name)

    # when passed 'updated_since' parameter
    if params[:updated_since].present?
      updated_since = params[:updated_since]
      date = Time.parse(updated_since)
      agencies = agencies.where('updated_at >= ?', date)
    end

    # when passed `category_id` parameter
    if params[:category_id].present?
      category_id = params[:category_id]
      agencies = agencies.joins(:categories).where("categories.id" => category_id)
    end

    # when passed `search` parameter
    if params[:search].present?
      agencies = agencies.search_name(params[:search])

      # when `address` or `coordinates` are passed
      if params[:address].present? || params[:coordinates].present?
        if params[:address].present?
          location = params[:address]
        else
          location = params[:coordinates] if params[:coordinates].present?
        end

        distance = params[:distance].present? ? params[:distance] : 20
        agencies = agencies.near(location, distance)
      end
      agencies = agencies.where(county: params[:county]) if params[:county].present?
    end

    agencies = agencies.map do |agency|
      agency.new_agency_hash
    end

    render json: agencies, status: :ok
  end
end
