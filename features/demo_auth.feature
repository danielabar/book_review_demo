Feature: User authentication

  Scenario: User logs in with valid credentials
    Given a user exists with email "user@example.com" and password "password"
    When I visit the login page
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "password"
    And I click "Log in"
    And I should see "Signed in as user@example.com" in the navigation bar
    And I should see a "Logout" button
