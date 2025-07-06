module ReviewHelpers
  def find_my_review
    all('[data-testid="review-item"]').find do |item|
      item.find('[data-testid="review-author"]').text == "You"
    end
  end
end

World(ReviewHelpers)
