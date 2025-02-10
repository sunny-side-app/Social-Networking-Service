require 'faker'

notification_types = ['like', 'follow', 'message']

Database::Seeds.define "notifications", columns: [:user_id, :notification_type] do
  notifications = []
  15.times do
    notifications << {
      user_id: rand(1..5),
      notification_type: notification_types.sample
    }
  end
  notifications
end
