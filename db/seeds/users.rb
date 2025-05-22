puts '🌱 Seeding users...'

User.destroy_all

5.times do |i|
  User.create!(
    email: "demo#{i + 1}@example.com",
    password: 'password'
  )
end

puts "✅ Created 5 demo users (demo1@example.com ... demo5@example.com)"
