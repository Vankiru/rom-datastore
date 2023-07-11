# frozen_string_literal: true

require 'google/cloud/datastore'
require_relative 'dataset'

module ROM
  module Datastore
    # Datastore gateway
    #
    # @example
    #   gateway = ROM::Datastore::Gateway.new(
    #     porject_id: 'datastore',
    #     credentials: 'path/to/credentials.json'
    #   )
    #
    #   users = gateway.dataset(:users)
    #
    # @api public
    class Gateway < ROM::Gateway
      adapter :datastore

      attr_reader :datastore, :datasets

      def initialize(options = nil)
        @datasets = Concurrent::Map.new

        @datastore = if options.nil?
                       Google::Cloud::Datastore.new
                     else
                       Google::Cloud::Datastore.new(
                         project_id: options[:project_id],
                         credentials: options[:credentials]
                       )
                     end
      end

      def [](name)
        datasets.fetch(name)
      end

      def dataset(name)
        datasets[name] = Dataset.new(datastore, datastore.query(name))
      end

      def dataset?(name)
        datasets.key?(name)
      end
    end
  end
end
