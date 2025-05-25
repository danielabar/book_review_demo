class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    # For a simple demo app, not using pagination
    @books = Book.all.includes(:reviews)
    # research:
    # @books = Book.all.includes(:reviews).select('books.*, COUNT(reviews.id) AS reviews_count').left_joins(:reviews).group('books.id')
  end

  def show
    @book = Book.find(params[:id])
    context = BookShowContextBuilder.new(book: @book, user: current_user)
    @user_review = context.user_review
    @review = context.review
    @reviews_to_show = context.reviews_to_show
  end
end
