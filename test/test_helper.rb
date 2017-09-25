require 'minitest/autorun'
require 'minitest/hooks/test'
require_relative '../app'
require 'rack_toolkit'

class RecipeerTest < MiniTest::Test
  include Minitest::Hooks
end
