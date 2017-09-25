require_relative '../test_helper'

class AuthorizationTest < RecipeerTest
  def setup
    Recipeer::Authentication.set_user('test-user', 'foo', '123')
  end

  def test_can_get_user
    assert Recipeer::Authentication.get_user('test-user', 'foo')
  end

  def test_raises_error_for_invalid_user
    assert_raises(Recipeer::InvalidUser) do
      Recipeer::Authentication.get_user('test-user', 'bar')
    end
  end

  def test_user_pass_is_hashed
    db_pass = Recipeer::Database.connection.users['test-user']
    assert 'foo' != db_pass
  end

  def test_returns_user_object
    user = Recipeer::Authentication.get_user('test-user', 'foo')
    assert_equal '123', user.auth_token
  end
end
