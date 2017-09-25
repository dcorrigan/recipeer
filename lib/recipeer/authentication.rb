require 'bcrypt'

module Recipeer
  module Authentication
    def self.set_user(username, pword)
      db_pword = BCrypt::Password.create(pword)
      Recipeer::Database.connection.add_user(username, db_pword)
    end

    def self.valid?(username, pword)
      user = Recipeer::Database.connection.users[username]
      return false unless user
      user == pword
    end
  end
end
