class Api::V1::CountiesController < ApplicationController

  def index
    counties = County.all.map {|c| {id: c.id, name: c.name, state: c.state} }
    render json: { counties: counties }, status: :ok
  end

end
