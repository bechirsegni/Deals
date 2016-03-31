class StaticPagesController < ApplicationController

  def index
  end

  def about
  end

  def restaurants
    @categories = Category.where(name: 'Restaurants & Bars')
    @subscategories = Category.where(:parent_id => @categories)
    @deals = Deal.where(category_id: '1').paginate(:page => params[:page], :per_page => 8)
  end

end
