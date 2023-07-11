# frozen_string_literal: true

module ROM
  module Datastore
    module Commands
      #  Datastore Update command
      #
      #  @api public
      class Update < ROM::Commands::Create
        adapter :datastore

        use :timestamps
        timestamp :updated_at

        restrictable true

        def execute(tuple)
          dataset.each do |entity|
            set(entity, tuple)
            dataset.save(entity)
          end

          relation
        end

        private

        def set(entity, tuple)
          tuple.each do |key, value|
            entity[key] = value
          end
        end

        def dataset
          relation.dataset
        end
      end
    end
  end
end
