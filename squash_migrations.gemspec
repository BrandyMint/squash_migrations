# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'squash_migrations/version'

Gem::Specification.new do |spec|
  spec.name          = 'squash_migrations'
  spec.version       = SquashMigrations::VERSION
  spec.authors       = ['Aleksandr B. Ivanov']
  spec.email         = %w(radanisk@ya.ru)
  spec.description   = %q{Squash migrations}
  spec.summary       = %q{Squash migrations}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rails'
end
