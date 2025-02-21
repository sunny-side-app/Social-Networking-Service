require 'faker'

Database::Seeds.define "likes", columns: [:user_id, :post_id] do
  likes = []
  5.times do
    likes << {
      user_id: rand(1..5),
      post_id: rand(1..5),
      like_receiver_id: rand(1..5)
    }
  end
  likes
end
