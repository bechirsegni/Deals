class DealsController < ApplicationController
  before_action :set_deal ,only:[:show, :edit, :update, :destroy, :vote]
  before_action :authenticate_user!, only: [:new,:create ,:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :beautify_search_url, only: [:index]

  def index
    @categories = Category.where(parent_id: nil)
    query = params[:q].presence || "*"
    @deals = Deal.search(query).records
  end

  def show
    if user_signed_in?
    @coupons = current_user.coupons.all
    end
  end

  def new
    @deal = current_user.deals.new
  end

  def create
    @deal = current_user.deals.build(deal_params)
    if @deal.save!
      redirect_to @deal, notice: "Your Deal Successfully Created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @deal.update(deal_params)
      redirect_to @deal , notice: "This Deal Successfully Modified"
    else
      render :edit
    end
  end

  def destroy
    if @deal.destroy!
      redirect_to root_path
    else
      render @deal
    end
  end

  def vote
    if request.put?
      @deal.upvote_from current_user
    elsif request.delete?
      @deal.downvote_from current_user
    end
     redirect_to :back
  end

  private

  def set_deal
    @deal = Deal.find(params[:id])
  end

  def deal_params
    params.require(:deal).permit(:title,:about,:prix_before,:prix_after,:category_id,
                                 :address,:timing,:email,:deadline,:menu,:conditions,
                                 :reservation,:city,:business,:cover_photo,
                                 :website,:phone,:facebook,:instagram,:user_id,
                                 :wifi, :parking,:music,:smoking)
  end

  def correct_user
    @deal = current_user.deals.find_by_id(params[:id])
    redirect_to deals_path, notice: "Not authorized to edit this Deal" if @deal.nil?
  end

  def beautify_search_url
    redirect_to search_deals_path(query: params[:q]) if params[:q].present?
  end
end