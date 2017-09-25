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

      def add_user(uname, pword)
        users[uname] = pword
        wrapped { @data['users'] = users }
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
