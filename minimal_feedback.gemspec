# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minimal_feedback/version'

Gem::Specification.new do |gem|
  gem.name          = "minimal_feedback"
  gem.version       = MinimalFeedback::VERSION
  gem.authors       = ["Matteo Depalo"]
  gem.email         = ["matteodepalo@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'activerecord'
  gem.add_dependency 'activesupport'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'debugger'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'sqlite3'
end
