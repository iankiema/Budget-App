class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @categories = current_user.categories
  end

  def show
    @category = Category.find(params[:id])
    @expenditures = @category.expenditures.order(created_at: :desc)
  end

  def new
    @category = current_user.categories.build
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      redirect_to categories_path, notice: 'Category created successfully.'
    else
      render :new
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.expenditures.destroy_all
    @category.destroy
    redirect_to categories_path, notice: 'Category was successfully destroyed.'
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
