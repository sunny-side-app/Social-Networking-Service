require 'faker'

Database::Seeds.define "private_messages", columns: [:sender_id, :receiver_id, :message_content] do
  private_messages = []
  5.times do
    sender = rand(1..5)
    receiver = rand(1..5)
    next if sender == receiver
    private_messages << {
      sender_id: sender,
      receiver_id: receiver,
      message_content: Faker::Lorem.sentence(word_count: rand(5..15))
    }
  end
  private_messages
end
