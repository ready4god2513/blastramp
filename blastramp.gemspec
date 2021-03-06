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

  s.add_dependency "activesupport", "~> 4.0.0"
  s.add_dependency "savon", "= 0.9.3"
  

  if s.respond_to?(:add_development_dependency)
    s.add_development_dependency "rspec", "~> 2.3.0"
    s.add_development_dependency "mocha", "~> 0.9.8"
    s.add_development_dependency "savon_spec", "~> 0.1.6"
  else
    s.add_dependency "rspec", "~> 2.3.0"
    s.add_dependency "mocha", "~> 0.9.8"
    s.add_dependency "savon_spec", "~> 0.1.6"
  end
end
