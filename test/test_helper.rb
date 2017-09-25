ENV['RECIPEER_ENVIRONMENT'] = 'test'

require 'minitest/autorun'
require 'minitest/hooks/test'
require 'rack_toolkit'
require 'webmock/minitest'
require_relative '../app'

class RecipeerTest < MiniTest::Test
  include Minitest::Hooks
end
