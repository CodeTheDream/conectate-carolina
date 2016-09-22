class SearchController < ApplicationController
  def search
    if params[:q].nil?
      @agencies = []
    else
      @agencies = Agency.search(params[:q])
    end
  end
end
