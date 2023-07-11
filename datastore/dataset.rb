# frozen_string_literal: true

require_relative 'dataset/datastore_interface'

module ROM
  module Datastore
    # Datastore Dataset
    #
    # @api public
    class Dataset
      include Enumerable
      include DatastoreInterface

      attr_reader :datastore

      def initialize(datastore, query)
        @datastore = datastore
        @query = query
      end

      def kind
        query.to_grpc.kind.first&.name
      end

      def each(&block)
        return to_enum unless block_given?
        datastore.run(query).each(&block)
      end

      # Queries

      def find(key)
        Find.new(datastore, kind, key)
      end

      def where(property, operator, value)
        build(query.dup.where(property, operator, value))
      end

      def order(property, direction)
        build(query.dup.order(property, direction))
      end

      def select(*properties)
        build(query.dup.select(*properties))
      end

      def ancestor(key)
        build(query.dup.ancestor(key))
      end

      def distinct_on(property)
        build(query.dup.distinct_on(property))
      end

      def limit(value)
        build(query.dup.limit(value))
      end

      def start(cursor)
        build(query.dup.start(cursor))
      end

      private

      attr_reader :query

      def build(query)
        self.class.new(datastore, query)
      end
    end
  end
end
