if Rails.env.development?
  puts 'Seeding development database...'

  require_relative './seeds/users'
  require_relative './seeds/books'
  require_relative './seeds/reviews'

  puts '✅ Seeding complete.'
else
  puts 'Seeding is only allowed in the development environment.'
  exit
end
