# frozen_string_literal: true

module ROM
  module Datastore
    class Entity
      def initialize(relation, entity)
        @relation = relation
        @entity = entity
      end

      def [](value)
        properties[value]
      end

      def []=(key, value)
        properties[key] = value
      end

      def each(&block)
        properties.each(&block)
      end

      def to_hash
        properties
      end

      private

      attr_reader :relation, :entity

      def properties
        return @properties if defined?(@properties)

        @properties = {}

        relation.schema.attributes.each do |attribute|
          @properties[attribute.name] = entity[attribute.name]
        end

        @properties[:id] = entity.key.id || entity.key.name

        @properties
      end
    end
  end
end
