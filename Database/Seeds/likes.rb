require 'faker'

Database::Seeds.define "likes", columns: [:user_id, :post_id, :liked_at] do
  likes = []
  5.times do
    likes << {
      user_id: rand(1..5),
      post_id: rand(1..10),
      liked_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
    }
  end
  likes
end
