class CategoriesController < ApplicationController
  def new
    @category = Category.new
    authorize @category
  end

  def index
    @categories = Category.all
    # @categories = Category.paginate(page: params[:page], per_page: 5)
    authorize @categories
  end

  def show
    @category = Category.find(params[:id])
    @category_agencies = @category.agencies.all #replace with paginate
    authorize @category
    #@category_agencies = @category.agencies.paginate(page: params[:page], per_page: 5)
  end

  def create
    @category = Category.new(category_params)
    authorize @category
    if @category.save
      flash[:notice] = "Category was created successfully"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def edit
		@category = Category.find(params[:id])
    authorize @category
  end

  def update
		@category = Category.find(params[:id])
    authorize @category
		if @category.update_attributes(category_params)
			flash[:notice] = (t'flash_notice.update')
			redirect_to @category
		else
			render  'edit'
		end
  end

  def destroy
    @category = Category.find(params[:id])
    authorize @category
		@category.destroy
		flash[:notice] = t 'flash_notice.delete'
		redirect_to new_category_url
  end

  private
  def category_params
    params.require(:category).permit(:name, :categoria)
  end
  #implement this method logged_in?
  # def require_admin
  #   if !logged_in? || (logged_in and !current_user.admin?)
  #     flash[:notice] = "Only admins can perform that action"
  #     redirect_to categories_path
  #   end
  # end
end
