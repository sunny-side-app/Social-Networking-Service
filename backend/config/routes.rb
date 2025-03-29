require_relative "../app/controllers/home_controller"
require_relative "../app/controllers/api/posts_controller"

MyRouter = Proc.new do |env|
  req = Rack::Request.new(env)
  path = req.path_info
  method = req.request_method

  puts "DEBUG: method=#{method.inspect}, path_info=#{path.inspect}"

  case method
  when 'GET'
    if path =~ %r{^/api/posts/(\d+)$}
      # $1 には (\d+) にマッチした文字列が入る(=postのid)
      post_id = $1.to_i
      return PostsController.new.show(req, post_id)
    end
  
    # 既存の /api/posts 一覧をマッチ
    if path == '/api/posts'
      return PostsController.new.timeline(req)
    end
  
    # 他のルート...
  end
  
  [404, { 'Content-Type' => 'application/json' }, [{ error: 'Not Found' }.to_json]]  
end
