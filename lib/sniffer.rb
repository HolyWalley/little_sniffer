# frozen_string_literal: true

require_relative "sniffer/version"
require_relative "sniffer/adapters/net_http_adapter"

# Sniffer allows to log http requests
module Sniffer
  # LittleSniffer allows to log http request locally
  class LittleSniffer
    UnsupportedAdapterError = Class.new(StandardError)
    HandlerDoesNotMatchTheInterfaceError = Class.new(StandardError)

    ADAPTERS_MAP = {
      net_http: Adapters::NetHttpAdapter
    }.freeze

    def initialize(handler, adapter = :net_http, &block)
      adapter = validate_adapter(adapter)
      validate_handler(handler)

      adapter.new(handler).sniff(&block)
    end

    private

    def validate_handler(handler)
      return if handler.respond_to?(:handle)

      raise HandlerDoesNotMatchTheInterfaceError
    end

    def validate_adapter(adapter)
      adapter = ADAPTERS_MAP[adapter]

      return adapter if adapter

      error_message = "maybe you have misspelled it. Appropriate types are: #{ADAPTERS_MAP.keys.join(', ')}"
      raise UnsupportedAdapterError, error_message
    end
  end
end
