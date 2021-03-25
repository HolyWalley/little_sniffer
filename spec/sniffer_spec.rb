# frozen_string_literal: true

require "spec_helper"

RSpec.describe Sniffer do
  let(:handler) do
    Class.new do
      def handle(data)
        data
      end
    end.new
  end

  let(:adapter) { instance_double(Sniffer::Adapters::NetHttpAdapter) }
  let(:block) { proc { puts "test" } }

  before do
    allow(Sniffer::Adapters::NetHttpAdapter).to receive(:new).with(handler).and_return(adapter)
    allow(adapter).to receive(:sniff)
  end

  it "has a version number" do
    expect(Sniffer::VERSION).not_to be nil
  end

  it "raises if adapter is of unsupported type" do
    expect { Sniffer::LittleSniffer.new(handler, :unsupported) }.to raise_error(Sniffer::LittleSniffer::UnsupportedAdapterError)
  end

  it "raises if handler doesnt support handle method" do
    expect { Sniffer::LittleSniffer.new(Class.new, :net_http) }.to raise_error(Sniffer::LittleSniffer::HandlerDoesNotMatchTheInterfaceError)
  end

  it "calls adapter with handler and block" do
    Sniffer::LittleSniffer.new(handler, :net_http, &block)

    expect(Sniffer::Adapters::NetHttpAdapter).to have_received(:new).with(handler)
    expect(adapter).to have_received(:sniff)
  end
end
