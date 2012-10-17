# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grape-cors/version'

Gem::Specification.new do |gem|
  gem.name          = "grape-cors"
  gem.version       = Grape::Cors::VERSION
  gem.authors       = ["Ash Berlin"]
  gem.email         = ["ash_github@firemirror.com"]
  gem.description   = %q{Adds (simple) support for Cross Origin requests to [grape]}
  gem.summary       = %q{Adds (simple) support for Cross Origin requests to [grape]}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
