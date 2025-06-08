# Sets up Warden test helpers for Cucumber feature specs in a Rails app using Devise.
# Devise uses Warden for authentication. Logging in via the UI in every test is slow.
# Warden test helpers let us log in users directly in tests (e.g., login_as(user)).
# This speeds up tests and avoids repetitive UI steps.
#
# Enable Warden's test mode so we can control authentication in tests.
Warden.test_mode!

# Make Warden test helper methods (like login_as) available in all steps.
World(Warden::Test::Helpers)

# Reset Warden's test state after each scenario to prevent state leakage.
After { Warden.test_reset! }
