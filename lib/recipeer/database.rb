require 'pstore'

module Recipeer
  module Database
    def self.connect
      @database ||= Recipeer::Database::Store.new("db/recipeer.#{Recipeer.config.environment}.pstore")
    end

    def self.connection
      connect
    end

    class Store
      def initialize(file)
        @data = PStore.new(file)
      end

      def users
        @users ||= wrapped do
          if @data['users']
            @data['users']
          else
            {}
          end
        end
      end

      def add_user(uname, pword, auth_token)
        users[uname] = [pword, auth_token]
        wrapped { @data['users'] = users }
      end

      def recipes
        @users ||= wrapped do
          if @data['recipes']
            @data['recipes']
          else
            {}
          end
        end
      end

      def add_recipe(uname, url, data)
        recipes[uname] ||= {}
        recipes[uname][url] = data
        wrapped { @data['recipes'] = recipes }
      end

      private

      def wrapped(&block)
        @data.transaction do
          yield
        end
      end
    end
  end
end
