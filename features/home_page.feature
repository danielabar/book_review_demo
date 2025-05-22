Feature: Home page

  Scenario: Guest sees welcome message and register button
    Given I am not signed in
    When I visit the home page
    Then I should see "Welcome to Book Review Demo"
    And I should see a "Register Now" link
    When I click link "Register Now"
    Then I should be on the registration page

  Scenario: Signed-in user sees welcome message and start reviewing button
    Given I am signed in as a user
    When I visit the home page
    Then I should see "Welcome to Book Review Demo"
    And I should see a "Start Reviewing" link
    When I click link "Start Reviewing"
    Then I should be on the books index page
