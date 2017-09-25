require_relative './test_helper'

class AppTest < RecipeerTest
  def before_all
    @server = RackToolkit::Server.new(app: RecipeerApp.app, start: true)
  end

  def test_case_name
    @server.get('/ingredients')
    assert_equal 'hello', @server.last_response.body
  end
end
