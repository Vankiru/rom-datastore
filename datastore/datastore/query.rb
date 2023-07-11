# frozen_string_literal: true

module Google
  module Cloud
    module Datastore
      class Query
        def dup
          query = self.class.new
          query.instance_variable_set('@grpc', @grpc.dup)
          query
        end
      end
    end
  end
end
