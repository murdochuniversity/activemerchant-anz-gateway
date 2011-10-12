# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require File.expand_path("#{__FILE__}/active_merchant-anz/version")

Gem::Specification.new do |s|
  s.name        = "activemerchant-anz"
  s.version     = ActiveMerchant::ANZ::VERSION
  s.authors     = ["Dirk Kelly"]
  s.email       = ["dk@dirkkelly.com"]
  s.homepage    = ""
  s.summary     = %q{Gateway for ANZ and ActiveMerchant}
  s.description = %q{Provides an interface to ANZ for the Activemerchant library, fork of github@anujluthra's work}

  s.rubyforge_project = "activemerchant-anz"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"

  s.add_runtime_dependency "activemerchant", "~ 1.18.1"
  s.add_runtime_dependency "activesupport", "~ 3.1.1"
end
