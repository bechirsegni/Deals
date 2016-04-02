class CouponsController < ApplicationController
  before_action :authenticate_user!, only:[:create]
  before_action :correct_user, only: [:destroy]


  def create
    @deal = Deal.find(params[:deal_id])
    @coupon = @deal.coupons.build(review_params)
    @coupon.user = current_user
    if @coupon.save!
      redirect_to :back
    end
  end

  def destroy
    @deal = Deal.find(params[:deal_id])
    @coupon.destroy
    redirect_to :back
  end

  private
  def review_params
    params.require(:coupon).permit(:number, :user_id)
  end

  def correct_user
    @coupon = current_user.coupons.find_by(id: params[:id])
    redirect_to deals_path, notice: "Not authorized to destroy this review" if @coupon.nil?
  end
end
