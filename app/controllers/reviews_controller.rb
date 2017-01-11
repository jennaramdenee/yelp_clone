class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    # if current_user.has_reviewed? @restaurant
    #   flash.next[:error] = ["You can only review restaurant once"]
    #   redirect_to '/restaurants'
    # end
    review = @restaurant.reviews.new(review_params)
    review.user = current_user
    if review.save
      redirect_to '/restaurants'
    else
      if review.errors[:user]
        flash.next[:error] = review.errors[:user]
        redirect_to '/restaurants'
      else
        render :new
      end
    end
  end

  private
  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
