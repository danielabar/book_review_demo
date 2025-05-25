Given("the following reviews exist:") do |table|
  table.hashes.each do |row|
    book = Book.find_by(title: row["Book"])
    user = User.find_by(email: row["User Email"]) || FactoryBot.create(:user, email: row["User Email"])
    FactoryBot.create(:review, book: book, user: user, rating: row["Rating"], body: row["Body"])
  end
end

Given("I have left a review for {string} with rating {int} and body {string}") do |book_title, rating, body|
  book = Book.find_by(title: book_title)
  user = User.find_by(email: "user1@example.com")
  FactoryBot.create(:review, book: book, user: user, rating: rating, body: body)
end

When("I visit the book show page for {string}") do |book_title|
  book = Book.find_by(title: book_title)
  visit book_path(book)
end

When("I enter a review with body {string} and rating {int}") do |body, rating|
  fill_in "Your Review", with: body
  select rating.to_s, from: "Rating (1-5)"
end

When("I click {string} on my review and confirm") do |button|
  accept_confirm do
    click_button button
  end
end

Then("I should see {string} in my review") do |text|
  # Find the review item where the author is 'You'
  my_review = all('[data-testid="review-item"]').find do |item|
    item.find('[data-testid="review-author"]').text == "You"
  end
  expect(my_review).not_to be_nil
  expect(my_review).to have_content(text)
end

Then("I should not see {string} in the reviews list") do |text|
  within('[data-testid="reviews-list"]') do
    expect(page).not_to have_content(text)
  end
end

Then("I should see {int} stars for my review") do |count|
  # Find the first review item where the author is 'You'
  my_review = all('[data-testid="review-item"]').find do |item|
    item.find('[data-testid="review-author"]').text == "You"
  end
  expect(my_review).not_to be_nil
  expect(my_review.find('[data-testid="review-rating"]').all('svg').size).to eq(count)
end

Then("I should see the book title, author, and published year for {string}") do |title|
  book = Book.find_by(title: title)
  within("##{dom_id(book)}") do
    expect(page).to have_content(book.title)
    expect(page).to have_content(book.author)
    expect(page).to have_content(book.published_year)
  end
end

Then("I should see \"You\" at the top of the reviews list") do
  first_item = all('[data-testid="review-item"]').first
  author = first_item.find('[data-testid="review-author"]').text
  expect(author).to eq("You")
end

Then("I should see the review for {string} with body {string} and {int} stars") do |email, body, star_count|
  within('[data-testid="reviews-list"]') do
    found = false
    all('[data-testid="review-item"]').each do |item|
      author = item.find('[data-testid="review-author"]').text
      review_body = item.find('[data-testid="review-body"]').text
      if author == email && review_body == body
        stars = item.find('[data-testid="review-rating"]').all('svg').size
        expect(stars).to eq(star_count)
        found = true
        break
      end
    end
    expect(found).to be true
  end
end

Then("I should see the review form in \"Add a Review\" mode") do
  expect(page).to have_content("Add a Review")
end

Then("I should see a submit review button") do
  expect(page).to have_button("Submit Review")
end
