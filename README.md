# Book Review Demo App

This is a demo Book Review application built with Ruby on Rails. It serves as a companion project for a blog post (link TBD) about feature testing in Rails using Cucumber. The app allows users to browse books, read and write reviews, and demonstrates my preferred approach to feature (system) testing in Rails - using Cucumber instead of the more commonly used RSpec/Capybara setup.

## Requirements

- Ruby version: see `.ruby-version` or `Gemfile`
- Rails version: see `Gemfile`
- System dependencies: see `Gemfile` and `bin/setup`
- SQLite (default), or configure your own database in `config/database.yml`

## Setup Instructions

1. **Clone the repository:**
   ```sh
   git clone <repo-url>
   cd book_review_demo
   ```

2. **Install dependencies:**
   ```sh
   bin/setup
   ```
   This will install Ruby gems, JavaScript packages, set up the database, and seed initial data.

3. **Start the development server:**
   ```sh
   bin/dev
   ```

4. **Access the app:**
   Open [http://localhost:3000](http://localhost:3000) in your browser.

## Running Tests

WIP

- **Feature tests (Cucumber):**
  ```sh
  bundle exec cucumber
  ```

## Database

- To reset the database:
  ```sh
  bin/rails db:reset
  ```
- To seed sample data:
  ```sh
  bin/rails db:seed
  ```

## Additional Notes

- This app is for demonstration and educational purposes.
- For questions or feedback, see the accompanying blog post or open an issue.

---

*Happy testing!*
