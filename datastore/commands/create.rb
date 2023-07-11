# frozen_string_literal: true

module ROM
  module Datastore
    module Commands
      #  Datastore Create command
      #
      #  @api public
      class Create < ROM::Commands::Create
        adapter :datastore

        use :timestamps
        timestamp :created_at, :updated_at

        def execute(tuple)
          [ROM::Datastore::Entity.new(source, create(tuple))]
        end

        private

        def create(tuple)
          entity = dataset.entity(relation.key.call(tuple))

          tuple.each do |key, value|
            entity[key] = value
          end

          dataset.save(entity)
          entity
        end

        def dataset
          relation.dataset
        end
      end
    end
  end
end
