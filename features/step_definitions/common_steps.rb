When("I click {string}") do |button|
  click_button button
end

When("I click link {string}") do |link|
  click_link link
end

Then("I should see {string}") do |text|
  expect(page).to have_content(text)
end

Then(/^I should see a "([^"]*)" button$/) do |text|
  expect(page).to have_button(text)
end

Then(/^I should see a "([^"]*)" link$/) do |text|
  expect(page).to have_link(text)
end
