# frozen_string_literal: true

# Service object to build all context needed for the books/show view
class BookShowContextBuilder
  attr_reader :book, :user, :user_review, :review, :other_reviews, :reviews_to_show

  def initialize(book:, user:)
    @book = book
    @user = user
    build_context
  end

  private

  def build_context
    @user_review = @book.reviews.find_by(user: @user)
    @review = @user_review || @book.reviews.new
    other_reviews = @book.reviews.includes(:user).where.not(user: @user).order(created_at: :desc)
    @reviews_to_show = []
    @reviews_to_show << @user_review if @user_review
    @reviews_to_show += other_reviews.to_a if other_reviews
  end
end
