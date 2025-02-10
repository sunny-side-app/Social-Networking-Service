require 'faker'

Database::Seeds.define "posts", columns: [:user_id, :content] do
  posts = []
  10.times do
    posts << {
      user_id: rand(1..5),
      content: Faker::Lorem.sentence(word_count: rand(5..20))
    }
  end
  posts
end
