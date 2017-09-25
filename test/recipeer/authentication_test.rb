require_relative '../test_helper'

class AuthorizationTest < RecipeerTest
  def setup
    @database = Recipeer::Database.connect
  end

  def test_can_set_user
    Recipeer::Authentication.set_user('test-user', 'foo')
    assert Recipeer::Authentication.valid?('test-user', 'foo')
  end

  def test_user_pass_is_hashed
    Recipeer::Authentication.set_user('test-user', 'foo')
    db_pass = Recipeer::Database.connection.users['test-user']
    assert 'foo' != db_pass
  end
end
