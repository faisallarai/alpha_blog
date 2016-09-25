class CategoriesController < ApplicationController

  before_action :set_category, only: [:edit, :update, :show, :destroy]
  before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create 
    @category = Category.new(category_params)
    @category.user = current_user
    if @category.save
      flash[:success] = "Category was created successfully"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    @category.user = current_user
    if @category.update(category_params)
      flash[:success] = "Category was successfully updated"
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @category.destroy
    flash[:danger] = "Category was successfully deleted"
    redirect_to categories_path
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :description)
    end

    def require_admin
      if !logged_in? || (logged_in? and !current_user.admin?)
        flash[:danger] = "Only admin can perform that action"
        redirect_to categories_path
      end
    end

end