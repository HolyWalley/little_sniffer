# frozen_string_literal: true

require_relative "little_sniffer/version"
require_relative "little_sniffer/adapters/net_http_adapter"

# LittleSniffer allows to log http request locally
class LittleSniffer
  HandlerDoesNotMatchTheInterfaceError = Class.new(StandardError)

  def initialize(handler:, adapter: Adapters::NetHttpAdapter, &block)
    validate_handler(handler)

    adapter.new(handler: handler).sniff(&block)
  end

  private

  def validate_handler(handler)
    return if handler.respond_to?(:call)

    raise HandlerDoesNotMatchTheInterfaceError
  end
end
