# scenario is an instance of: Cucumber::RunningTestCase::TestCase
# See: https://github.com/cucumber/cucumber-ruby-core/tree/11863bd62ce0ccad1c9d39741ac3d9af191f8136/lib/cucumber/core
After do |scenario|
  if scenario.failed?
    # scenario.location.to_s gives e.g. "features/book_reviews.feature:42"
    file, line = scenario.location.to_s.split(":")
    feature = File.basename(file, ".feature")
    scenario_name = scenario.name.gsub(/\W+/, "_")
    path = "html-report/#{feature}_#{scenario_name}_line_#{line}.png"
    page.save_screenshot(path)
    attach(path, "image/png")
  end
end
