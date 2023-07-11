# frozen_string_literal: true

module ROM
  module Datastore
    # Datastore Dataset
    #
    # @api public
    class Dataset
      module DatastoreInterface
        def entity(id)
          datastore.entity(kind, id)
        end

        def save(entity)
          datastore.save(entity)
        end

        def delete(entity)
          datastore.delete(entity)
        end
      end
    end
  end
end
