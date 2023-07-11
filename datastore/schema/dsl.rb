# frozen_string_literal: true

module ROM
  module Datastore
    class Schema < ROM::Schema
      # Specialized schema DSL with Datastore-specific features
      class DSL < ROM::Schema::DSL
        attr_reader :key_block

        def key(*attributes, &block)
          if attributes.any?
            @key_block = key_from_attrs(attributes)
          elsif block
            @key_block = block
          end
        end

        private

        def key_from_attrs(attributes)
          ->(tuple) do
            key = attributes.map { |attribute|
              if tuple[attribute].nil?
                ::Kernel.raise KeyAttributeError.new(attribute)
              end

              tuple[attribute]
            }

            key.join('-')
          end
        end

        # Return schema options
        #
        # @api private
        def opts
          if key_block
            {**super, key: key_block}
          else
            super
          end
        end
      end
    end
  end
end
