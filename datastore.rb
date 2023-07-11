# frozen_string_literal: true

require_relative 'datastore/datastore/query'

require_relative 'datastore/errors'
require_relative 'datastore/entity'
require_relative 'datastore/gateway'
require_relative 'datastore/dataset'
require_relative 'datastore/schema'
require_relative 'datastore/relation'
require_relative 'datastore/commands'

ROM.register_adapter(:datastore, ROM::Datastore)
