# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "api_pi/version"

Gem::Specification.new do |g|
  g.name    = 'api_pi'
  g.version = ApiPi::VERSION

  g.summary     = "API validation DSL"
  g.description = "A ruby DSL to investigate and validate API requests."

  g.authors = "Ben Woodall"
  g.email   = "mail@benwoodall.com"

  g.files      = `git ls-files`.split("\n")
  g.test_files = `git ls-files -- test/*`.split("\n")

  g.extra_rdoc_files      = ["README.md"]

  g.add_dependency             'map', '~> 6.6'
  g.add_development_dependency 'minitest', '~>5.24.1'
  g.add_development_dependency 'webmock', '~> 3.23.1'
  g.add_development_dependency 'rake', '~> 13.2.1'
end
