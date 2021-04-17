# frozen_string_literal: true

require "spec_helper"

RSpec.describe LittleSniffer do
  let(:handler) do
    proc { |data| data }
  end

  let(:adapter) { instance_double(described_class::Adapters::NetHttpAdapter) }
  let(:block) { proc { puts "test" } }

  before do
    allow(described_class::Adapters::NetHttpAdapter).to receive(:new).with(handler).and_return(adapter)
    allow(adapter).to receive(:sniff)
  end

  it "has a version number" do
    expect(described_class::VERSION).not_to be nil
  end

  it "raises if adapter is of unsupported type" do
    expect { described_class.new(handler, :unsupported) }.to raise_error(described_class::UnsupportedAdapterError)
  end

  it "raises if handler doesnt support call method" do
    expect { described_class.new(Class.new, :net_http) }.to raise_error(described_class::HandlerDoesNotMatchTheInterfaceError)
  end

  it "calls adapter with handler and block" do
    described_class.new(handler, :net_http, &block)

    expect(described_class::Adapters::NetHttpAdapter).to have_received(:new).with(handler)
    expect(adapter).to have_received(:sniff)
  end
end
