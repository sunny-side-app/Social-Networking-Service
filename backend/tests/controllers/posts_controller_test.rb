# tests/posts_controller_test.rb
require 'minitest/autorun'
require 'rack'
require 'json'
require_relative '../../config/routes'

class PostsControllerTest < Minitest::Test
  def setup
    @app = MyRouter
  end

  def test_trend_timeline
    # GET /api/posts?tab=trend&offset=0&limit=20 のエンドポイントテスト
    env = Rack::MockRequest.env_for("/api/posts?tab=trend&offset=0&limit=20", method: "GET")
    status, headers, body = @app.call(env)

    assert_equal 200, status
    # charset が付く場合もあるので include? で確認
    assert_includes headers["Content-Type"], "application/json"
    data = JSON.parse(body.join)
    assert data.is_a?(Array)
    # ※ テスト実行時のDB状態に合わせたアサーション（件数や内容のチェック）を追加可能
  end

  def test_followers_timeline_without_user_id
    # フォロワータイムラインの場合、user_id が無いと400エラーになることを確認
    env = Rack::MockRequest.env_for("/api/posts?tab=followers&offset=0&limit=20", method: "GET")
    status, _headers, body = @app.call(env)

    assert_equal 400, status
    data = JSON.parse(body.join)
    assert_equal "Missing user_id parameter for followers timeline", data["error"]
  end

  def test_invalid_tab_parameter
    env = Rack::MockRequest.env_for("/api/posts?tab=invalid", method: "GET")
    status, _headers, body = @app.call(env)
    assert_equal 400, status
    data = JSON.parse(body.join)
    assert_equal "Invalid tab parameter", data["error"]
  end
end
