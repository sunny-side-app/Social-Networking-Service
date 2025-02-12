require 'faker'

notification_types = ['like', 'follow', 'message']

Database::Seeds.define "notifications", columns: [:user_id, :type] do
  notifications = []
  5.times do
    notifications << {
      user_id: rand(1..5),
      type: notification_types.sample
    }
  end
  notifications
end
