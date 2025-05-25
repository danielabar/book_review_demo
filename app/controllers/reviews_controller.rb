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
