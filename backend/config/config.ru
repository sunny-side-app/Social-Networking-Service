# config/routes.rb
require_relative '../app/controllers/api_controller'
require_relative '../app/controllers/home_controller'

MyRouter = Proc.new do |env|
  req = Rack::Request.new(env)
  case [req.request_method, req.path_info]
  when ['GET', '/']
    HomeController.new.index(req)
  when ['GET', '/api/posts']
    ApiController.new.list_posts(req)
  when ['POST', '/api/posts']
    ApiController.new.create_post(req)
  else
    [404, { "Content-Type" => "application/json" }, [{ error: "Not Found" }.to_json]]
  end
end
