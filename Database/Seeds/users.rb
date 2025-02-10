require 'faker'
require 'digest'  # シンプルなハッシュ生成のため

Database::Seeds.define "users", columns: [
  :user_name, :mail_address, :password, :age, :location, :hobby, :profile_image
] do
  (1..5).map do |_i|
    {
      user_name: Faker::Internet.unique.username(specifier: 5..8),
      mail_address: Faker::Internet.email,
      password: Digest::SHA256.hexdigest("password"),
      age: rand(18..70),
      location: Faker::Address.city,
      hobby: Faker::Lorem.sentence(word_count: 10),
      profile_image: Faker::Avatar.image
    }
  end
end
