require 'open-uri'
require 'hangry'
require 'ingreedy'

module Recipeer
  # will be responsible for gleaning recipe data
  module Reaper
    def self.update_recipe_list

    end

    class UserRecipes
      def initialize(username, auth_token)
        @username = username
        @auth_token = auth_token
      end

      def api_endpoint
        "https://api.pinboard.in/v1/all?tag=recipes&auth_token=#{@username}:#{@auth_token}"
      end

      def recipe_list
        @recipe_list ||= JSON.load(web_body(api_endpoint))
      end

      def add_recipes
        recipe_list.each do |recipe|
          add_recipe(recipe_json)
        end
      end

      def add_recipe(recipe_json)
        body = web_body(recipe_json['href'])
        recipe = Hangry.parse(body)
        node = {name: recipe.name, ingredients: recipe.ingredients}
        Recipeer::Database.connection.add_recipe(@username, recipe_json['href'], node)
      end

      private

      def web_body(uri)
        open(uri).read
      end
    end
  end
end
