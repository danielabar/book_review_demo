# Custom Database Cleaner configuration for Cucumber.
#
# We use the :truncation strategy for all scenarios because Capybara JS drivers (like Cuprite)
# run the app and test code in separate processes, so transactional cleaning does not work.
# This ensures the test database is cleaned between scenarios, preventing leftover data.

DatabaseCleaner.strategy = :truncation
