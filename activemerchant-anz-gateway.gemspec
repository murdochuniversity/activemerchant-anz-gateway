require File.expand_path("../lib/active_merchant-anz/version", __FILE__)

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "activemerchant-anz-gateway"
  s.version     = ActiveMerchant::Anz::VERSION
  s.authors     = ["Anuj Luthra", "Dirk Kelly"]
  s.email       = ["anuj.luthra@gmail.com", "dk@dirkkelly.com"]
  s.homepage    = ""
  s.summary     = %q{Gateway for ANZ and ActiveMerchant}
  s.description = %q{Provides an interface to ANZ for the Activemerchant library, fork of github@anujluthra's work}

  s.rubyforge_project = "activemerchant-anz-gateway"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "test-unit"
  s.add_development_dependency "mocha"

  s.add_runtime_dependency "activemerchant"
  s.add_runtime_dependency "activesupport"
end
