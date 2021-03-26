# frozen_string_literal: true

require "bundler/setup"
require "httpclient"
require "jsonclient"
require 'base64'
require 'http'
require 'patron'
require "net/http"
require "uri"
require "json"
require "curl"
require "typhoeus"
require "ethon"
require "em-http-request"
require "excon"

require "sniffer"
require "pry-byebug"

Dir[File.expand_path(File.join(File.dirname(__FILE__), 'support', '**', '*.rb'))].sort.each { |f| require f }

@server_thread = Thread.new do
  FakeWeb::App.run!
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
