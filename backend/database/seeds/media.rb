require 'faker'

media_types = ['png', 'mp3']

Database::Seeds.define "media", columns: [:post_id, :media_type] do
  media = []
  5.times do
    media << {
      post_id: rand(1..5),
      media_type: media_types.sample
    }
  end
  media
end