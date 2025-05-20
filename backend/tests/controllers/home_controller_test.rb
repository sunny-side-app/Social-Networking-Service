require 'minitest/autorun'
require 'rack'
require_relative '../../config/routes'

class HomeControllerTest < Minitest::Test
  def setup
    @app = MyRouter
  end

  # ルートは API が扱わないので 404 を期待
  def test_root_returns_404
    env = Rack::MockRequest.env_for("/", method: "GET")
    status, _headers, _ = @app.call(env)  # _変数で未使用警告回避
    assert_equal 404, status
  end
end
