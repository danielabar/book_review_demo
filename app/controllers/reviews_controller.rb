class ReviewsController < ApplicationController
  before_action :authenticate_user!


  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @book, notice: "Review was successfully created."
    else
      context = BookShowContextBuilder.new(book: @book, user: current_user)
      @user_review = context.user_review
      @review = @review # keep the invalid review for error display
      @other_reviews = context.other_reviews
      @reviews_to_show = context.reviews_to_show
      render "books/show", status: :unprocessable_entity
    end
  end

  def update
    @book = Book.find(params[:book_id])
    @review = @book.reviews.find_by(user: current_user)
    if @review.update(review_params)
      redirect_to @book, notice: "Review was successfully updated."
    else
      context = BookShowContextBuilder.new(book: @book, user: current_user)
      @user_review = context.user_review
      @review = @review # keep the invalid review for error display
      @reviews_to_show = context.reviews_to_show
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
