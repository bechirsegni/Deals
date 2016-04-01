class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:wishlist]

  def index
    @deals = Deal.all.limit(9).order(id: :desc)
  end

  def about
  end

  def wishlist
    @deals = current_user.get_up_voted(Deal).paginate(:page => params[:page], :per_page => 4)
  end

  def restaurants
    @categories = Category.where(name: 'Restaurants & Bars')
    @subscategories = Category.where(:parent_id => @categories)
    @deals = Deal.where(category_id: '1').paginate(:page => params[:page], :per_page => 8)
  end

end
