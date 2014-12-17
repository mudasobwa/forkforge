# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'forkforge/version'

Gem::Specification.new do |spec|
  spec.name          = "forkforge"
  spec.version       = Forkforge::VERSION
  spec.authors       = ["Alexei Matyushkin"]
  spec.email         = ["am@mudasobwa.ru"]
  spec.summary       = %q{Unicode handling library}
  spec.description   = %q{Support for UnicodeData.txt as by Consortium}
  spec.homepage      = "http://forkforge.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-rescue"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'cucumber'
  spec.add_development_dependency 'yard-cucumber'
end
