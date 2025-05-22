Feature: Books index

  # The Background section sets up data and state that will be created before each scenario runs.
  # Any books, reviews, or user sign-ins defined here will be reset between scenarios,
  # especially when using Database Cleaner or similar tools to ensure a clean database state.
  # This helps keep each scenario independent and repeatable.
  Background:
    Given the following books exist:
      | Title      | Author   | Published Year |
      | Book One   | Author A | 2001           |
      | Book Two   | Author B | 2002           |
      | Book Three | Author C | 2003           |
    And the following reviews exist:
      | Book     | User Email        | Rating | Body        |
      | Book One | user1@example.com | 5      | Great book! |
      | Book One | user2@example.com | 4      | Good read.  |
      | Book Two | user1@example.com | 3      | It was ok.  |
    And I am signed in as "user1@example.com"

  Scenario: User sees all books with review counts
    When I visit the books index page
    Then I should see the following books:
      | Title      | Author   | Published Year | Review Count |
      | Book One   | Author A | 2001           | 2 reviews    |
      | Book Two   | Author B | 2002           | 1 review     |
      | Book Three | Author C | 2003           | 0 reviews    |

  Scenario: User navigates to a book show page
    When I visit the books index page
    And I click on "Book One"
    Then I should be on the book show page for "Book One"
