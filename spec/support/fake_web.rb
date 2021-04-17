# frozen_string_literal: true

require "rack"
require "rack/handler/thin"
module FakeWeb
  class App
    def call(env)
      req = Rack::Request.new(env)

      case req.path_info
      when '/'
        [200, { "content-length" => "2" }, "OK"]
      when '/data'
        [201, { "content-length" => "7" }, "Created"]
      when '/json'
        [200, { "content-type" => "text/json" }, "{\"status\":\"OK\"}"]
      end
    end
  end
end
