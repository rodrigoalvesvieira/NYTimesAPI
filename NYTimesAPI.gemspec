# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'NYTimesAPI/version'

Gem::Specification.new do |spec|
  spec.name          = "NYTimesAPI"
  spec.version       = NYTimesAPI::VERSION
  spec.authors       = ["Rodrigo Alves"]
  spec.email         = ["rodrigovieira1994@gmail.com"]
  spec.summary       = %q{The New York Times API}
  spec.description   = %q{The New York Times API wrapper}
  spec.homepage      = "https://github.com/rodrigoalvesvieira/NYTimesAPI"
  spec.license       = "MIT"

  spec.files = Dir["{lib/**/*,spec/*}"] + Dir.entries(".").select { |f| File.file?(f) }.reverse[0..6] - ["NYTimesAPI-0.0.1.gem"]

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
