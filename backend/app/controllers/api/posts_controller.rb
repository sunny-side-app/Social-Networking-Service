require 'json'
require_relative '../../helpers/validation_helper'
require_relative '../../models/post'
require_relative '../../../database/data_access/dao_factory'

class PostsController
  # GET /api/posts?tab=trend&offset=0&limit=20
  # GET /api/posts?tab=followers&user_id=123&offset=0&limit=20
  def timeline(req)
    tab    = req.params["tab"] || "trend"
    offset = (req.params["offset"] || 0).to_i
    limit  = (req.params["limit"] || 20).to_i

    dao = Database::DataAccess::DAOFactory.get_dao("posts")

    if tab == "trend"
      rows = dao.timeline_trend(limit, offset)
    elsif tab == "followers"
      user_id = req.params["user_id"]
      unless user_id
        return [400, { "Content-Type" => "application/json" }, [{ error: "Missing user_id parameter for followers timeline" }.to_json]]
      end
      rows = dao.timeline_followers(user_id, limit, offset)
    else
      return [400, { "Content-Type" => "application/json" }, [{ error: "Invalid tab parameter" }.to_json]]
    end

    posts = rows.map do |row|
      post = Post.new(
        id: row[:id],
        user_id: row[:user_id],
        content: row[:content],
        media_url: row[:media_url],
        scheduled_at: row[:scheduled_at],
        created_at: row[:created_at]
      )
      hash = post.to_hash
      hash[:like_count] = row["like_count"] || row[:like_count] if row["like_count"] || row[:like_count]
      hash
    end

    [200, { "Content-Type" => "application/json" }, [posts.to_json]]
  end

  # ※ 他の投稿関連のアクション（create, delete など）は必要に応じて追加
end
