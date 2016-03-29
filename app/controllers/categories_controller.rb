class CategoriesController < ApplicationController
  before_action :set_category ,only:[:edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @categories = Category.where("parent_id IS NULL")
    @category = current_user.categories.new
  end

  def get_subscategories
    @subscategories = Category.where(:parent_id => params[:parent_id])
    render :partial => 'subscategories', :object => @subscategories
  end
  def new
    @category = current_user.categories.new
  end

  def edit
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      redirect_to categories_url
    else
      render :new
    end
  end

  def update
    if @category.update_attributes(params[:category].permit!)
      redirect_to categories_url
    else
      render :edit
    end
  end

  def destroy
    Category.destroy(params[:id])
    redirect_to categories_url
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name,:parent_id,:lft,:rgt)
  end

  def correct_user
    @category = current_user.categories.find_by_id(params[:id])
    redirect_to categories_path, notice: "Not authorized to edit this Post" if @category.nil?
  end
end