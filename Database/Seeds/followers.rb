require 'faker'
require 'set'

Database::Seeds.define "followers", columns: [:follower_id, :user_id] do
  unique_pairs = Set.new

  # 目標件数（例: 5件）のユニークなフォロー関係が生成されるまでループする
  while unique_pairs.size < 5
    follower = rand(1..5)
    user_id  = rand(1..5)
    # 自分自身のフォローは除外
    next if follower == user_id
    # キーとして "#{follower}_#{user_id}" を作成
    key = "#{follower}_#{user_id}"
    unique_pairs.add(key)
  end

  # Set 内の文字列を解析して、ハッシュの配列に変換する
  unique_pairs.map do |pair|
    follower, user_id = pair.split('_').map(&:to_i)
    { follower_id: follower, user_id: user_id }
  end
end
