class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  def create
    @deal = Deal.find(params[:deal_id])
    @review = @deal.reviews.build(review_params)
    @review.user = current_user
    if @review.save!
      respond_to do |format|
        format.html do
          flash[:success] = 'Comment posted.'
          redirect_to @deal
        end
        format.js
      end
    end
  end

  def destroy
    @deal = Deal.find(params[:deal_id])
    @review.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'Comment Delete.'
        redirect_to @deal
      end
      format.js
    end
  end

  private
  def review_params
    params.require(:review).permit(:body, :user_id)
  end

  def correct_user
    @review = current_user.reviews.find_by(id: params[:id])
    redirect_to deal_path, notice: "Not authorized to destroy this review" if @review.nil?
  end
end
