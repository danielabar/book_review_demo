Feature: User authentication

  Scenario: User registers for an account
    Given I am not signed in
    When I visit the registration page
    And I fill in the registration form with valid data
    And I submit the registration form
    Then I should be signed in
    And I should see "Signed in as" in the navigation bar

  Scenario: User logs in with valid credentials
    Given a user exists with email "user@example.com" and password "password"
    When I visit the login page
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "password"
    And I click "Log in"
    Then I should be signed in
    And I should see "Signed in as user@example.com" in the navigation bar
    And I should see a "Logout" button

  Scenario: Failed login with incorrect password
    Given a user exists with email "user@example.com" and password "password"
    When I visit the login page
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "wrongpassword"
    And I click "Log in"
    Then I should see "Invalid Email or password"
    And I should not be signed in

  Scenario: Failed login with non-existent email
    Given I am not signed in
    When I visit the login page
    And I fill in "Email" with "nonexistent@example.com"
    And I fill in "Password" with "anypassword"
    And I click "Log in"
    Then I should see "Invalid Email or password"
    And I should not be signed in

  Scenario: Failed login with empty credentials
    Given I am not signed in
    When I visit the login page
    And I click "Log in"
    Then I should see "Invalid Email or password"
    And I should not be signed in

  Scenario: Navigation bar for guest
    Given I am not signed in
    When I visit the home page
    Then I should see "Login" and "Register" links in the navigation bar
    And I should not be signed in
