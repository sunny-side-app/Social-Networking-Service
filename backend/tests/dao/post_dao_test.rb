require 'minitest/autorun'
require 'json'
require_relative '../../database/data_access/dao_factory'

class PostDAOTest < Minitest::Test
  def setup
    @dao = Database::DataAccess::DAOFactory.get_dao("posts")
  end

  def test_timeline_trend_returns_array
    # テスト用のデータセットが存在している前提。なければ、テスト前にseed処理を行うなど。
    result = @dao.timeline_trend(20, 0)
    assert result.is_a?(Array)
  end
end
