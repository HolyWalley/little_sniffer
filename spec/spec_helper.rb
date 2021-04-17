# frozen_string_literal: true

require "bundler/setup"
require 'base64'
require "net/http"
require "uri"
require "json"

require "little_sniffer"

Dir[File.expand_path(File.join(File.dirname(__FILE__), 'support', '**', '*.rb'))].sort.each { |f| require f }

@server_thread = Thread.new do
  Rack::Handler::Thin.run FakeWeb::App.new, Port: 4567
end

sleep 1

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
