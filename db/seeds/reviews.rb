puts '🌱 Seeding reviews...'

Review.delete_all

users = User.all.to_a
books = Book.order("RANDOM()").limit(10)

books.each do |book|
  reviewers = users.shuffle.sample(rand(1..[ users.size, 5 ].min))
  reviewers.each do |user|
    some_date = rand(0..365).days.ago
    Review.create!(
      book: book,
      user: user,
      rating: rand(1..5),
      body: Faker::Lorem.paragraph(sentence_count: 3),
      created_at: some_date,
      updated_at: some_date
    )
  end
end

puts "✅ Created reviews for 10 random books"
