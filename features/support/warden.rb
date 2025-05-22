# features/support/warden.rb
Warden.test_mode!
World(Warden::Test::Helpers)
After { Warden.test_reset! }
