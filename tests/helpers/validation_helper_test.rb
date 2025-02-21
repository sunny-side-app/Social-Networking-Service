require 'minitest/autorun'
require_relative '../backend/app/helpers/validation_helper'

class ValidationHelperTest < Minitest::Test
  def test_present
    assert ValidationHelper.present?("abc")
    refute ValidationHelper.present?("  ")
    refute ValidationHelper.present?(nil)
  end

  def test_validate_params
    params = { "content" => "Hello", "user_id" => "1" }
    rules = {
      content: { presence: true, min_length: 1 },
      user_id: { presence: true }
    }
    errors = ValidationHelper.validate_params(params, rules)
    assert_empty errors

    params2 = { "content" => "" }
    errors2 = ValidationHelper.validate_params(params2, rules)
    refute_empty errors2
  end
end
