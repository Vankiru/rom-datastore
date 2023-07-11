# frozen_string_literal: true

require_relative 'schema/dsl'

module ROM
  module Datastore
    class Relation < ROM::Relation
      adapter :datastore

      include Enumerable

      schema_class Datastore::Schema
      schema_dsl Datastore::Schema::DSL

      forward :find, :where, :order, :select,
        :ancestor, :distinct_on, :limit,
        :start

      def kind
        dataset.kind
      end

      def key
        schema.key
      end

      def each(&block)
        return to_enum unless block_given?

        if auto_map?
          mapper.call(dataset.map { |tuple| proccess_tuple(tuple) }).each { |struct| yield(struct) }
        else
          dataset.each { |tuple| yield(proccess_tuple(tuple)) }
        end
      end

      def delete
        command(:delete).call
      end

      private

      def proccess_tuple(tuple)
        output_schema[ROM::Datastore::Entity.new(self, tuple)]
      end
    end
  end
end
