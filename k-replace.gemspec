$:.push File.expand_path("../lib", __FILE__)

require "k/replace/version"

Gem::Specification.new do |s|
  s.name          = "k-replace"
  s.version       = K::Replace::VERSION::STRING
  s.authors       = ["Reinaldo Oliveira"]
  s.email         = ["reinaldooli@gmail.com"]

  s.summary       = "A key to value replacement for text"
  s.description   = "Replace keys in text for an object attribute"
  s.homepage      = "https://github.com/reinaldooli/k-replace"
  s.license       = "MIT"

  s.platform      = Gem::Platform::RUBY

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency "minitest", "~> 5.10"
  s.add_development_dependency "minitest-utils", "~> 0.4"
  s.add_development_dependency "pry-meta", "~> 0.0"
end
