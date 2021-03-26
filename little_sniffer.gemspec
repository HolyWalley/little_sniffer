# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "little_sniffer/version"

Gem::Specification.new do |spec|
  spec.name          = "little_sniffer"
  spec.version       = LittleSniffer::VERSION
  spec.authors       = ["Yakau Kranou"]
  spec.email         = ["yasha.krasnov@gmail.com"]

  spec.summary       = %q{Analyze HTTP Requests}
  spec.description   = %q{Analyze HTTP Requests}
  spec.homepage      = "http://github.com/HolyWalley/little_sniffer"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "sinatra", "~> 2.0"
  spec.add_development_dependency "puma", ">= 3.10.0"
end
