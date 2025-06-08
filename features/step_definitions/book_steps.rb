Given("the following books exist:") do |table|
  table.hashes.each do |row|
    create(:book, title: row["Title"], author: row["Author"], published_year: row["Published Year"])
  end
end

When("I visit the books index page") do
  visit books_path
end

When("I click on {string}") do |book_title|
  click_link book_title
end

Then("I should be on the books index page") do
  expect(current_path).to eq(books_path)
end

Then("I should be on the book show page for {string}") do |book_title|
  book = Book.find_by(title: book_title)
  expect(current_path).to eq(book_path(book))
end

# Each row is a hash like: {"Title" => "Book One", "Author" => "Author A", "Published Year" => "2001", "Review Count" => "2 reviews"}
Then("I should see the following books:") do |table|
  table.hashes.each do |row|
    book = Book.find_by(title: row["Title"])
    within("#book_#{book.id}") do
      expect(page).to have_content(row["Title"])
      expect(page).to have_content(row["Author"])
      expect(page).to have_content(row["Published Year"])
      expect(page).to have_content(row["Review Count"])
    end
  end
end
