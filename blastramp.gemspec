# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "blastramp/version"

Gem::Specification.new do |s|
  s.name        = "blastramp"
  s.version     = Blastramp::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["cnantais"]
  s.email       = ["cnantais@gmail.com"]
  s.homepage    = "http://zkron.com"
  s.summary     = %q{Blastramp Shipping Services Client Library}
  s.description = %q{Blastramp Shipping Services Client Library for polling inventory and submitting shipping orders.}

  s.rubyforge_project = "blastramp"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "activesupport", "~> 3.0.3"
  s.add_development_dependency "rspec", "~> 2.3.0"
  s.add_development_dependency "mocha", "~> 0.9.8"
  s.add_development_dependency "savon", "= 0.9.3"
  s.add_development_dependency "savon_spec", "~> 0.1.6"
end
