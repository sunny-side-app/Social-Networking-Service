require_relative "../app/controllers/home_controller"
require_relative "../app/controllers/api/posts_controller"

MyRouter = Proc.new do |env|
  req = Rack::Request.new(env)
  path = req.path_info
  method = req.request_method

  puts "DEBUG: method=#{method.inspect}, path_info=#{path.inspect}"

  case [method, path]
  when ['GET', '/']
    HomeController.new.index(req)
  when ['GET', %r{^/api/posts$}]
    PostsController.new.timeline(req)
  else
    [404, { "Content-Type" => "application/json" }, [{ error: "Not Found" }.to_json]]
  end
end
