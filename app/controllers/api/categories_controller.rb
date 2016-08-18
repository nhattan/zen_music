class Api::CategoriesController < ApiController
  def index
    if current_user.admin?
      @categories = Category.all
    else
      @categories = Category.limited_access
    end
  end

  def show
    if current_user.admin?
      @category = Category.find params[:id]
    else
      @category = Category.limited_access.find params[:id]
    end
  end
end
