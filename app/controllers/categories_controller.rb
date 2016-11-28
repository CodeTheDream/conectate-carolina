class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def index
    @categories = Category.all
    # @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def show
    @category = Category.find(params[:id])
    @category_agencies = @category.agencies.all #replace with paginate
    #@category_agencies = @category.agencies.paginate(page: params[:page], per_page: 5)
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was created successfully"
      redirect_to categories_path
    else
      render 'new'
    end
  end
  
  def edit
		@category = Category.find(params[:id])
  end
  
  def update
		@category = Category.find(params[:id])
		if @category.update_attributes(category_params)
			flash[:notice] = (t'flash_notice.update')
			redirect_to @category
		else
			render  'edit'
		end
  end
  
  private
  def category_params
    params.require(:category).permit(:name)
  end
  #implement this method logged_in?
  # def require_admin
  #   if !logged_in? || (logged_in and !current_user.admin?)
  #     flash[:notice] = "Only admins can perform that action"
  #     redirect_to categories_path
  #   end
  # end
end
