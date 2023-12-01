class ExpendituresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category
  before_action :set_categories, only: %i[new create edit update]

  def index
    @category = Category.find(params[:category_id])
    @expenditures = @category.expenditures
  end

  def new
    @expenditure = @category.expenditures.build
    @categories = current_user.categories
  end

  def edit
    @expenditure = Expenditure.find(params[:id])
  end

  def create
    @expenditure = current_user.expenditures.build(expenditure_params)
    @categories = current_user.categories

    if @expenditure.save
      redirect_to category_expenditures_path(@category), notice: 'Expenditure was successfully created.'
    else
      render :new
    end
  end

  def update
    @expenditure = Expenditure.find(params[:id])
    if @expenditure.update(expenditure_params)
      redirect_to category_expenditures_path(@category),
                  notice: 'Expenditure was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @expenditure = Expenditure.find(params[:id])
    @expenditure.destroy
    redirect_to category_expenditures_path(params[:category_id]),
                notice: 'Expenditures was successfully destroyed.'
  end

  private

  def expenditure_params
    params.require(:expenditure).permit(:name, :amount, :category_id)
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_categories
    @categories = current_user.categories
  end
end
