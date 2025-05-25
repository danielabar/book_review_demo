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

# table is instance of: Cucumber::MultilineArgument::DataTable
# table.raw is an array of arrays, for example:
# [["There were some problems with your submission:"], ["Body can't be blank"]]
# table.raw.flatten is a single array of strings, for example:
# ["There were some problems with your submission:", "Body can't be blank"]
Then("I should see the following form validation messages:") do |table|
  within('[data-testid="form-validation-errors"]') do
    table.raw.flatten.each do |msg|
      expect(page).to have_content(msg)
    end
  end
end
