# frozen_string_literal: true

module ROM
  module Datastore
    # Specialized schema for Datastore
    #
    # @api public
    class Schema < ROM::Schema
      # @!attribute [r] key
      #   @return
      option :key, default: -> { ->(tuple) {} }

      # Finalize associations
      #
      # @api private
      def finalize_associations!(relations:)
        super do
          associations.map do |definition|
            Datastore::Associations.const_get(definition.type).new(definition, relations)
          end
        end
      end
    end
  end
end
