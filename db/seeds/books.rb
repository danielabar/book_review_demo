puts '🌱 Seeding books...'

Book.delete_all

titles = Set.new
book_count = 0

while book_count < 30
  title = Faker::Book.title
  next if titles.include?(title)

  begin
    Book.create!(
      title: title,
      author: Faker::Book.author,
      published_year: rand(1900..2025),
      # image_url: "https://picsum.photos/200/300?random=#{book_count + 1}"
    )
    titles.add(title)
    book_count += 1
  rescue ActiveRecord::RecordInvalid => e
    puts "Skipping invalid book: #{e.message}"
  end
end

puts "✅ Created 30 books"
