# frozen_string_literal: true

module ROM
  module Datastore
    module Commands
      #  Datastore Delete command
      #
      #  @api public
      class Delete < ROM::Commands::Create
        adapter :datastore

        restrictable true

        def execute
          dataset.each do |entity|
            dataset.delete(entity)
          end

          relation
        end

        private

        def dataset
          relation.dataset
        end
      end
    end
  end
end
