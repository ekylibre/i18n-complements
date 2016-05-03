# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'i18n/complements/version'

Gem::Specification.new do |s|
  s.name = 'i18n-complements'
  s.version = I18n::Complements::VERSION
  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.author = 'Brice Texier'
  s.email = 'burisu@oneiros.fr'
  s.summary = 'I18n missing functionnalities'
  s.extra_rdoc_files = ['LICENSE', 'README.rdoc']
  s.test_files = `git ls-files test`.split("\n")
  s.files = `git ls-files lib README.rdoc LICENSE`.split("\n")
  s.homepage = 'http://github.com/burisu/i18n-complements'
  s.license = 'MIT'
  s.require_path = 'lib'
  s.add_dependency('i18n', '>= 0.6')
  s.add_development_dependency('coveralls', '>= 0.6.3')
  s.add_development_dependency('term-ansicolor')
  s.add_development_dependency('minitest')
  s.add_development_dependency('rake', '> 10')
end
