After do |scenario|
  if scenario.failed?
    feature = File.basename(scenario.location.file, ".feature")
    scenario_name = scenario.name.gsub(/\W+/, "_")
    path = "html-report/#{feature}_#{scenario_name}.png"
    page.save_screenshot(path)
    attach(path, "image/png")
  end
end
