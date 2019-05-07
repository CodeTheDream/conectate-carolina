class Api::V1::CategoriesController < ApplicationController
    # Get / categories
    def index
        @categories = Category.all
        @categories2 = @categories.map { |category| category.new_category_hash }
        render json: @categories2, status: :ok
    end
end
