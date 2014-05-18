# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'edinet_code/version'

Gem::Specification.new do |spec|
  spec.name          = "edinet_code"
  spec.version       = EdinetCode::VERSION
  spec.authors       = ["utahta"]
  spec.email         = ["labs.ninxit@gmail.com"]
  spec.summary       = %q{Get the edinet code list from EDINET}
  spec.description   = %q{Get the edinet code list from EDINET}
  spec.homepage      = "https://github.com/utahta/edinet_code"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency 'selenium-webdriver', '2.40.0'
  spec.add_dependency 'headless', '1.0.1'
  spec.add_dependency 'rubyzip', '1.1.2'
end
