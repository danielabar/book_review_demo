# Take a screenshot on failure after each scenario
After do |scenario|
  if scenario.failed?
    path = "html-report/#{scenario.__id__}.png"
    page.save_screenshot(path)
    attach(path, 'image/png')
  end
end
