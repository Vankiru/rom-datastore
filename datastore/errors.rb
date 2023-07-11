# frozen_string_literal: true

module ROM
  module Datastore
    class Error < StandardError; end

    class KeyAttributeError < Error
      def initialize(attribute)
        super("#{attribute}")
      end
    end
  end
end
