# This file integrates FactoryBot's syntax methods into Cucumber's World.
# By including `World(FactoryBot::Syntax::Methods)`, we make FactoryBot's DSL methods
# (such as `create`, `build`, `attributes_for`, etc.) available directly in our step definitions.
# This means you can write `create(:user)` instead of `FactoryBot.create(:user)` in your
# `xxx_steps.rb` files. This improves readability and keeps your step definitions concise.
#
# What is `World`?
# `World` is a method provided by the Cucumber gem. It allows you to add modules or helper methods
# to the context in which your step definitions run. By passing a module to `World`, all its methods
# become available as if they were defined in every step definition file. This is how we make FactoryBot's
# methods available everywhere in our Cucumber tests.
World(FactoryBot::Syntax::Methods)
