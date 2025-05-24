Feature: Book reviews

  Background:
    Given the following books exist:
      | Title      | Author   | Published Year |
      | Book One   | Author A | 2001           |
      | Book Two   | Author B | 2002           |
    And users exist:
      | Email             | Password  |
      | user1@example.com | password1 |
      | user2@example.com | password2 |
    And the following reviews exist:
      | Book     | User Email        | Rating | Body       |
      | Book One | user2@example.com | 4      | Good read. |
    And I am signed in as "user1@example.com"

  Scenario: User sees book details and reviews
    When I visit the book show page for "Book One"
    Then I should see the book title, author, and published year for "Book One"
    And I should see the review for "user2@example.com" with body "Good read." and 4 stars
    And I should see a submit review button

  Scenario: User sees book details page for a book with no reviews
    When I visit the book show page for "Book Two"
    Then I should see the book title, author, and published year for "Book Two"
    And I should see "No reviews yet. Be the first to add one!"

  Scenario: User adds a review
    When I visit the book show page for "Book One"
    And I fill in "Your Review" with "Amazing!"
    And I select "5" for "Rating"
    And I click "Submit Review"
    Then I should see "Review was successfully created."
    And I should see "You" at the top of the reviews list
    And I should see "Amazing!" in my review
    And I should see 5 stars for my review

  Scenario: User edits their review
    Given I have left a review for "Book One" with rating 3 and body "It was ok."
    When I visit the book show page for "Book One"
    Then I should see 3 stars for my review
    And I update my review body to "Actually, I loved it!" and rating to 5
    And I click "Update Review"
    Then I should see "Review was successfully updated."
    And I should see "Actually, I loved it!" in my review
    And I should see 5 stars for my review

  Scenario: User deletes their review
    Given I have left a review for "Book One" with rating 3 and body "It was ok."
    When I visit the book show page for "Book One"
    And I click "Delete" on my review and confirm
    Then I should see "Review was successfully deleted."
    And I should not see "It was ok." in the reviews list
    And I should see the review form in "Add a Review" mode
