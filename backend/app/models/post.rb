class Post
  attr_accessor :id, :user_id, :parent_post_id, :content, :scheduled_at,
                :url, :status, :reply_nice_number, :del_flg, :created_at, :updated_at

  def initialize(id: nil, user_id:, parent_post_id: nil, content:, scheduled_at: nil,
                 url: nil, status: nil, reply_nice_number: 0, del_flg: false,
                 created_at: Time.now, updated_at: Time.now)
    @id                = id
    @user_id           = user_id
    @parent_post_id    = parent_post_id
    @content           = content
    @scheduled_at      = scheduled_at
    @url               = url
    @status            = status
    @reply_nice_number = reply_nice_number
    @del_flg           = del_flg
    @created_at        = created_at
    @updated_at        = updated_at
  end

  def to_hash
    {
      id:                id,
      user_id:           user_id,
      parent_post_id:    parent_post_id,
      content:           content,
      scheduled_at:      scheduled_at,
      url:               url,
      status:            status,
      reply_nice_number: reply_nice_number,
      del_flg:           del_flg,
      created_at:        created_at,
      updated_at:        updated_at
    }
  end
end
