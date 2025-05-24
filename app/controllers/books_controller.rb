class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    # For a simple demo app, not using pagination
    @books = Book.all.includes(:reviews)
    # research:
    # @books = Book.all.includes(:reviews).select('books.*, COUNT(reviews.id) AS reviews_count').left_joins(:reviews).group('books.id')
  end

  def show
    # FIXME: Not all of these instance vars are actually needed in the books show view
    @book = Book.find(params[:id])
    @user_review = @book.reviews.find_by(user: current_user)
    @review = @user_review || @book.reviews.new
    @other_reviews = @book.reviews.includes(:user).where.not(user: current_user).order(created_at: :desc)
    @reviews_to_show = []
    @reviews_to_show << @user_review if @user_review
    @reviews_to_show += @other_reviews.to_a if @other_reviews
  end
end
