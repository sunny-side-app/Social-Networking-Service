require 'faker'

Database::Seeds.define "schedules", columns: [:post_id, :post_date] do
  schedules = []
  5.times do
    schedules << {
      post_id: rand(1..5),
      post_date: Faker::Time.forward(days:2, period: :morning).strftime("%Y-%m-%d %H:%M:%S")
    }
  end
  schedules
end
