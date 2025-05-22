Given("I am signed in as {string}") do |email|
  user = User.find_by(email: email) || FactoryBot.create(:user, email: email)
  login_as(user, scope: :user)
end

# This step uses FactoryBot to create a user and Warden's test helpers to sign them in directly.
# This avoids navigating to the login or registration page and filling in forms, which is much slower.
# Using Warden's test mode is the recommended approach for feature specs that require a signed-in user.
Given("I am signed in as a user") do
  user = FactoryBot.create(:user)
  login_as(user, scope: :user)
end

Given("a user exists with email {string} and password {string}") do |email, password|
  FactoryBot.create(:user, email: email, password: password)
end

Given("I am not signed in") do
  logout(:user) if defined?(logout)
end

When("I visit the registration page") do
  visit new_user_registration_path
end

When("I visit the login page") do
  visit new_user_session_path
end

When("I fill in the registration form with valid data") do
  fill_in "Email", with: "newuser@example.com"
  fill_in "Password", with: "password"
  fill_in "Password confirmation", with: "password"
end

When("I submit the registration form") do
  click_button "Sign up"
end

When("I fill in {string} with {string}") do |field, value|
  fill_in field, with: value
end

Then("I should be signed in") do
  expect(page).to have_content("Signed in as")
end

Then("I should see {string} in the navigation bar") do |text|
  within("nav") { expect(page).to have_content(text) }
end

Then("I should see {string} and {string} links in the navigation bar") do |login, register|
  within("nav") do
    expect(page).to have_link(login)
    expect(page).to have_link(register)
  end
end

Then("I should not see {string}") do |text|
  expect(page).not_to have_content(text)
end

Then("I should be on the registration page") do
  expect(current_path).to eq(new_user_registration_path)
end
