require "capybara/cuprite"

Capybara.default_driver = :cuprite
Capybara.javascript_driver = :cuprite

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    window_size: [ 1920, 1080 ],
    js_errors: true,
    headless: !ENV["VISIBLE_BROWSER"],
    timeout: 10,
    browser_options: {
      "no-sandbox" => nil # Required if using Docker
    }
  )
end

# Why is this needed if timeout is specified above?
Capybara.default_max_wait_time = 5
