class Api::CategoriesController < Api::ApplicationController
  def index
    if current_user.admin?
      @categories = Category.all
    else
      @categories = Category.normal
    end
  end

  def show
    if current_user.admin?
      @category = Category.find params[:id]
    else
      @category = Category.normal.find params[:id]
    end
  end
end
