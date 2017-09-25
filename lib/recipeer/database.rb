module Recipeer
  module Database
    # will determine the correct file per-env
    # will return Store object for getting data
    def self.connect(environment)
    end

    class Store
      def initialize(file)
        @data = Pstore.new(file)
      end
    end
  end
end
