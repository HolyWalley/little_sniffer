# frozen_string_literal: true

require "logger"

require_relative "sniffer/version"

# Sniffer allows to log http requests
module Sniffer
end

require_relative "sniffer/adapters/net_http_adapter"
