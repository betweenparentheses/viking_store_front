class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(whitelisted_category_params)
    if @category.save
      flash[:success] = "Category created successfully."
      redirect_to category_path(@category.id)
    else
      flash.now[:error] = "Failed to create Category."
      render new_category_path
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(whitelisted_category_params)
      flash[:success] = "Category updated successfully."
      redirect_to category_path(@category.id)
    else
      flash.now[:error] = "Failed to update Category."
      render new_category_path
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:success] = "Category deleted successfully."
      redirect_to categories_path
    else
      flash[:error] = "Failed to delete Category."
      redirect_to category_path(@category.id)
    end
  end

  private

  def whitelisted_category_params
    params.require(:category).permit(:name)
  end
end