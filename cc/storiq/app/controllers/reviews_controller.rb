class ReviewsController < ApplicationController
  def create
    @review = Review.create(review_params)
    if @review.valid?
      redirect_to root_path, flash: { success: "The review has been successfully posted" }
    else
      # Same as for entities. TODO: Implement a new / edit page
      redirect_to root_path, flash: { errors: @review.errors.full_messages }
    end
  end

  private

  def review_params
    params.require(:review).permit(:entity_id, :score, :title)
  end
end
