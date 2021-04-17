# frozen_string_literal: true

require "spec_helper"

RSpec.describe LittleSniffer do
  let(:handler) do
    proc { |data| data }
  end

  let(:adapter_klass) { class_double(described_class::Adapters::NetHttpAdapter) }
  let(:adapter) { instance_double(described_class::Adapters::NetHttpAdapter) }
  let(:block) { proc { puts "test" } }

  before do
    allow(adapter_klass).to receive(:new).with(handler: handler).and_return(adapter)
    allow(adapter).to receive(:sniff)
  end

  it "has a version number" do
    expect(described_class::VERSION).not_to be nil
  end

  it "raises if handler doesnt support call method" do
    expect { described_class.new(handler: Class.new, adapter: adapter_klass) }.to raise_error(described_class::HandlerDoesNotMatchTheInterfaceError)
  end

  it "calls adapter with handler and block" do
    described_class.new(handler: handler, adapter: adapter_klass, &block)

    expect(adapter_klass).to have_received(:new).with(handler: handler)
    expect(adapter).to have_received(:sniff)
  end
end
