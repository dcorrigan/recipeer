require 'bcrypt'

module Recipeer
  class InvalidUser < ArgumentError; end

  module Authentication
    def self.set_user(username, pword, auth_token = nil)
      db_pword = BCrypt::Password.create(pword)
      Recipeer::Database.connection.add_user(username, db_pword, auth_token)
    end

    def self.get_user(username, pword)
      user_data = Recipeer::Database.connection.users[username]
      raise Recipeer::InvalidUser unless user_data && user_data[0] == pword
      OpenStruct.new(
        username: username,
        pword: user_data[0],
        auth_token: user_data[1]
      )
    end
  end
end
