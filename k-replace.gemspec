$:.push File.expand_path("../lib", __FILE__)

require "k/replace/version"

Gem::Specification.new do |s|
  s.name          = "k-replace"
  s.version       = K::Replace::VERSION::STRING
  s.authors       = ["Reinaldo Oliveira"]
  s.email         = ["reinaldooli@gmail.com"]

  s.summary       = "A key to value replacement for text"
  s.description   = s.summary
  s.license       = "MIT"

  s.platform      = Gem::Platform::RUBY

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency "minitest"
  s.add_development_dependency "minitest-utils"
  s.add_development_dependency "pry-meta"
end
