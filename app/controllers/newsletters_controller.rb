class NewslettersController < ApplicationController

  def create
    @newsletter = Newsletter.create(newsletters_params)
    if @newsletter.save!
      redirect_to :back
    end
  end

  private

  def newsletters_params
    params.require(:newsletter).permit(:email)
  end

end