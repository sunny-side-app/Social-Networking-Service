require 'minitest/autorun'
require 'rack'
require_relative '../backend/config/routes'

class HomeControllerTest < Minitest::Test
  def setup
    @app = MyRouter
  end

  def test_home_index_returns_html
    env = Rack::MockRequest.env_for("/", method: "GET")
    status, headers, body = @app.call(env)
    assert_equal 200, status
    assert_includes headers["Content-Type"], "text/html"
    # index.html の内容が含まれているか（例：React のエントリーポイントとしての特定文字列など）をチェック
  end
end
