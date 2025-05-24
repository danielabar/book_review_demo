class ReviewsController < ApplicationController
  before_action :authenticate_user!

  # FIXME: create and update methods - if theres a validation error, the page will not show the reviews
  # Need to extract this logic from books controller show method to somewhere common like a helper or service:
  # @reviews_to_show = []
  # @reviews_to_show << @user_review if @user_review
  # @reviews_to_show += @other_reviews.to_a if @other_reviews

  # FIXME: The book show view refers to `@user_review` not `@review`

  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @book, notice: "Review was successfully created."
    else
      # don't think this instance var is needed, but we do need others
      @reviews = @book.reviews.order(created_at: :desc) # to re-render the review list
      render "books/show", status: :unprocessable_entity
    end
  end

  def update
    @book = Book.find(params[:book_id])
    @review = @book.reviews.find_by(user: current_user)
    if @review.update(review_params)
      redirect_to @book, notice: "Review was successfully updated."
    else
      # don't think these instance vars are needed, but we do need others
      @user_review = @review
      @other_reviews = @book.reviews.includes(:user).where.not(user: current_user).order(created_at: :desc)
      render "books/show", status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @review = @book.reviews.find_by(user: current_user)
    @review.destroy if @review
    redirect_to @book, notice: "Review was successfully deleted."
  end

  private

  def review_params
    params.require(:review).permit(:body, :rating)
  end
end
