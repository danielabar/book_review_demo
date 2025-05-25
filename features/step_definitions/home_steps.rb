When("I visit the home page") do
  visit root_path
end

Then("I should be on the home page") do
  expect(current_path).to eq(root_path)
end
