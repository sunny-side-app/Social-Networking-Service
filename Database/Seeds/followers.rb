require 'faker'

Database::Seeds.define "followers", columns: [:follower_id, :user_id] do
  followers = []
  5.times do
    follower = rand(1..5)
    user_id = rand(1..5)
    next if follower == user_id
    followers << {
      follower_id: follower,
      user_id: user_id
    }
  end
  followers
end
