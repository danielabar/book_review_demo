- [Cucumber Setup](#cucumber-setup)
  - [1. Installation](#1-installation)
  - [2. Initialization](#2-initialization)
  - [3. Configuration](#3-configuration)
    - [Driver](#driver)
    - [Database Cleaner](#database-cleaner)
    - [Factory Bot](#factory-bot)
    - [Warden/Devise](#wardendevise)
    - [Silence Publish Message](#silence-publish-message)
  - [4. Run Feature Tests](#4-run-feature-tests)
  - [References](#references)
  - [Agentic](#agentic)
  - [Brainstorming](#brainstorming)
    - [WIP Review Management Edge Cases](#wip-review-management-edge-cases)
    - [User Permissions/Authorization](#user-permissionsauthorization)
    - [Navigation](#navigation)
    - [Logout Functionality](#logout-functionality)

# Cucumber Setup

## 1. Installation

Update `Gemfile` test section as follows, note we replace `selenium-webdriver` with `cuprite`:
```ruby
group :test do
  gem "shoulda-matchers"
  gem "capybara"
  gem "cuprite"
  gem "cucumber-rails", require: false
  gem "database_cleaner"
end
```

## 2. Initialization

```bash
rails generate cucumber:install
```

This generates `features` dir as follows:
```
features
├── All your *.feature tests go here
├── step_definitions
│   ├── .keep
│   └── All your *_steps.rb step definitions go here
└── support
    ├── Any other *.rb support can go here and is auto loaded
    └── env.rb Do not modify this generated file
```

## 3. Configuration

### Driver

Introduce cuprite config for capybara: `features/support/cuprite.rb`.

Important: Must register JS driver otherwise Capybara will run with `:rack_test` driver which does not run any JavaScript, but this must be defined at the beginning of the file.

We also add env var support to toggle between HEADLESS and VISIBLE mode, which is useful when you want an actual browser to open so you can see what's happening as the tests run.

```ruby
require "capybara/cuprite"

Capybara.default_driver = :cuprite
Capybara.javascript_driver = :cuprite

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    window_size: [ 1920, 1080 ],
    js_errors: true,
    headless: !ENV["VISIBLE_BROWSER"],
    timeout: 10,
    browser_options: {
      "no-sandbox" => nil # Required if using Docker
    }
  )
end

# Why is this needed if timeout is specified above?
Capybara.default_max_wait_time = 5
```

### Database Cleaner

TBD

### Factory Bot

TBD

### Warden/Devise

TBD

### Silence Publish Message

The installation command also generated `config/cucumber.yml`, modify `std_opts` to silence publish message:

```yml
std_opts = "--format #{ENV['CUCUMBER_FORMAT'] || 'pretty'} --strict --tags 'not @wip' --publish-quiet"
```

## 4. Run Feature Tests

```
bundle exec cucumber
```

## References

* [cuprite](https://github.com/rubycdp/cuprite)
* [ferrum customization options](https://github.com/rubycdp/ferrum#customization)
* [cucumber-rails](https://github.com/cucumber/cucumber-rails)
* [cucumber home](https://cucumber.io/docs/)
* [cucumber syntax](https://cucumber.io/docs/gherkin/reference/)
* [cucumber step definitions](https://cucumber.io/docs/cucumber/step-definitions/)

## Agentic

Write all the cucumber features tests (and scenarios within each, and step definitions) that should be written to fully cover this book review app with feature testing, keeping in mind this project uses devise, also factorybot is available.
Feature tests should exercise full workflows rather than smaller units which should be left up to unit tests.
Step definitions should be organized, and re-usable where appropriate.
To verify that a user can sign in, navigate to the login page and fill out username and password, but for all other tests that require a signed in user, integrate the warden/devise helper with cucumber, which would speed things up rather than having to literally sign in each time via the UI.
Here is what can be done with this app:
* if a guest visits home page, they see a welcome message, and a button for registering, which navigates to the signup page where they can create an account
* if a logged in user visits home page, they see the same welcome message, but the call to action button is to start reviewing, which navigates to the books index view
* on the books index view, a logged in user can view all the books where each book card shows the title, author, published date, and also how many reviews have been left on the book so far (which could be 0 more more). Consider if this test has something like "given the following books exist" it could use that cucumber "table" syntax, where the corresponding step iterates through the table rows and uses factorybot to create the given data.
* a logged in user can click on any book from the books index view which will navigate to the book show view, this view shows the book title, author, published, and lists all reviews which show the review body, reviewer address, when it was last updated in human time ago format, and also a star visual so if user left a 3 out of 5 review, it would show three stars
* if one of the reviews belongs to the logged in user, then that always displays at the top of the list and shows "You" instead of their email address.
* also on the book show view, a logged in user can add a review (but only if they haven't already) - providing a body, and selecting a rating
* also on the book show view, if the logged in user has already left a review, then they can edit it, modifying body and/or rating
* also on the book show view, if the logged in user has already left a review, they can delete it - this will have a js "are you sure" alert, if they click OK on that, then book is deleted, they will be redirected to book show view with a deleted flash message and their review is no longer in the list of reviews, at this point the form is in the "new" version and they can add their own review
* if a user is logged in, then the top navigation bar shows "Signed in as youremail" and they see a logout button
* if a user is not logged in, then the top navigation bar shows Login and Register links and does not show the "Signed in as..." message

## Brainstorming

### WIP Review Management Edge Cases
- Attempt to submit a second review for the same book (UI doesn't even allow this, maybe belongs as model test)
- Navigating away from review form and returning (data preservation)
- Review with very long content
- Malicious content in review body (XSS testing)

### User Permissions/Authorization
- Ensuring users can only edit/delete their own reviews
- Attempting to edit other users' reviews (should be prevented)
- Attempting to access protected routes without authentication
- Proper redirection to login when accessing protected content

### Navigation
- Complete user journey across the entire application
- Navigation between different sections retains correct state
- Back button behavior in critical workflows

### Logout Functionality
- User logs out and is properly redirected to home page
- After logout, protected content is no longer accessible
- User session is properly terminated
- Revisiting the site after logout requires new authentication
