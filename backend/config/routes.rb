require_relative '../database/data_access/dao_factory'
require_relative '../database/data_access/implementations/post_dao'

require_relative '../app/controllers/home_controller'
require_relative '../app/controllers/api/posts_controller'

MyRouter = Proc.new do |env|
  req  = Rack::Request.new(env)
  path = req.path_info
  method = req.request_method

  puts "DEBUG: method=#{method.inspect}, path_info=#{path.inspect}"

  # 1) ルーティング結果を一旦変数に格納
  route_result = case method
                 when 'GET'
                   if path == '/'
                     # 例: "/" を HomeController で処理
                     HomeController.new.index(req)

                   elsif path =~ %r{^/api/posts/(\d+)$}
                     # e.g. /api/posts/123
                     post_id = $1.to_i
                     PostsController.new.show(req, post_id)

                   elsif path == '/api/posts'
                     # /api/posts?tab=trend など
                     PostsController.new.timeline(req)

                   else
                     [404, { 'Content-Type' => 'application/json' }, [{ error: 'Not Found' }.to_json]]
                   end

                 else
                   # GET以外は 404 or 405
                   [404, { 'Content-Type' => 'application/json' }, [{ error: 'Not Found' }.to_json]]
                 end

  # 2) route_result は [status, headers, body] の3要素配列
  #    CORSのためにヘッダーを追加
  status, headers, body = route_result

  allowed_origin = ENV['ALLOWED_ORIGIN'] || '*'
  headers['Access-Control-Allow-Origin'] = allowed_origin

  # 3) 最後に配列を返す
  [status, headers, body]
end
