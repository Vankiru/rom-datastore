# frozen_string_literal: true

require 'rom/associations/one_to_many'

module ROM
  module Datastore
    module Associations
      class OneToMany < ROM::Associations::OneToMany
        def call(target:)
        end
      end
    end
  end
end
