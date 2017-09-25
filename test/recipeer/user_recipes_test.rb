require_relative '../test_helper'
require 'json'

class UserRecipesTest < RecipeerTest
  SAMPLE_HTML = File.read(File.join(__dir__, '..', 'samples/recipe.html'))
  def setup
    @expected_body = [
      {
        'href' => 'http://www.food.com',
        'description' => 'A Very Good Recipe',
      }
    ]
    stub_request(:any, /https:\/\/api.pinboard.in.*/).to_return(body: @expected_body.to_json)
    stub_request(:any, /food/).to_return(body: SAMPLE_HTML)
    @user_recipes = Recipeer::Reaper::UserRecipes.new('test-user', '123')
  end

  def test_can_get_raw_recipes
    recipes = @user_recipes.recipe_list
    assert_equal @expected_body, recipes
  end

  def test_can_add_recipe
    @user_recipes.add_recipe(@expected_body.first)
    recipe = Recipeer::Database.connection.recipes['test-user'][@expected_body.first['href']]
    assert_equal 'Pommes Frites', recipe[:name]
  end
end
