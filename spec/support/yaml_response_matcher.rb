# frozen_string_literal: true

require 'yaml'

RSpec::Matchers.define :match_yaml_file do |path|
  def expected(path = nil)
    @expected ||= begin
      yaml_directory = "#{Dir.pwd}/spec/yaml"
      file_path = "#{yaml_directory}/#{path}.yaml"
      file = File.read(file_path)
      YAML.load(file)
    end
  end

  match do |actual|
    actual[:response][:timing] = 0.0006

    expect(actual).to eq(expected(path))
  end

  failure_message do |actual|
    "expected that actual \n#{actual}\nwould be equal to\n#{expected}"
  end
end
