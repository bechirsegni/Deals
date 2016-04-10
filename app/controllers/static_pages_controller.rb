class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:wishlist]

  def index
    @deals = Deal.limit(9).order(id: :desc).includes(:category)
  end

  def about
  end

  def coupon
  end

  def wishlist
    @deals = current_user.get_up_voted(Deal).paginate(:page => params[:page], :per_page => 4)
  end

  def restaurants
    @categories = Category.where(name: 'Restaurants & Bars')
    @subscategories = Category.where(:parent_id => @categories)
    @deals = Deal.where(category_id: '1').paginate(:page => params[:page], :per_page => 8)
  end

  def discover
    @categories = Category.where(name: 'Discover')
    @subscategories = Category.where(:parent_id => @categories)
    @deals = Deal.where(category_id: '7').paginate(:page => params[:page], :per_page => 8)
  end

  def beauty_spas
    @categories = Category.where(name: 'Beauty & Spas')
    @subscategories = Category.where(:parent_id => @categories)
    @deals = Deal.where(category_id: '5').paginate(:page => params[:page], :per_page => 8)
  end

  def gadgets
    @categories = Category.where(name: 'Gadgets')
    @subscategories = Category.where(:parent_id => @categories)
    @deals = Deal.where(category_id: '6').paginate(:page => params[:page], :per_page => 8)
  end

end
