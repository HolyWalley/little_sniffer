# frozen_string_literal: true

require "net/http"
require "benchmark"

class LittleSniffer
  module Adapters
    class NetHttpAdapter
      def initialize(handler)
        @handler = handler
      end

      def sniff
        Net::HTTP.define_method(:request_with_sniffer, build_request_with_sniffer(@handler))
        Net::HTTP.alias_method(:request_without_sniffer, :request)
        Net::HTTP.alias_method(:request, :request_with_sniffer)

        yield
      ensure
        Net::HTTP.alias_method(:request, :request_without_sniffer)
        Net::HTTP.remove_method(:request_with_sniffer)
        Net::HTTP.remove_method(:request_without_sniffer)
      end

      private

      # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      def build_request_with_sniffer(handler)
        lambda do |req, body = nil, &block|
          data = {
            request: {
              host: @address,
              method: req.method,
              query: req.path,
              port: @port,
              headers: req.each_header.collect.to_h,
              body: req.body.to_s
            }
          }

          bm = Benchmark.realtime do
            @response = request_without_sniffer(req, body, &block)
          end

          data[:response] = {
            status: @response.code.to_i,
            headers: @response.each_header.collect.to_h,
            body: @response.body.to_s,
            timing: bm
          }

          handler.handle(data)

          @response
        end
      end
      # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
    end
  end
end
