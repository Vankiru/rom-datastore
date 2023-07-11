# frozen_string_literal: true

require_relative 'datastore_interface'

module ROM
  module Datastore
    # Datastore Dataset
    #
    # @api public
    class Dataset
      class Find
        include Enumerable
        include DatastoreInterface

        attr_reader :kind

        def initialize(datastore, kind, key)
          @datastore = datastore
          @kind = kind
          @key = key
        end

        def each(&block)
          return to_enum unless block_given?
          execute.each(&block)
        end

        private

        attr_reader :datastore, :key

        def execute
          entity = datastore.find(kind, key)
          entity ? [entity] : []
        end
      end
    end
  end
end
