module Recipeer
  # accessor methods for basic config
  def self.config
    @config ||= Recipeer::Config.new
  end

  class Config
    def environment
      @environment ||= case ENV['RECIPEER_ENV']
      when 'test'
        :test
      when 'production'
        :production
      else
        :development
      end
    end
  end
end
