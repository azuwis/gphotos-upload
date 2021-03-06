# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gphotos/version'

Gem::Specification.new do |spec|
  spec.name          = "gphotos"
  spec.version       = Gphotos::VERSION
  spec.authors       = ["Zhong Jianxin"]
  spec.email         = ["azuwis@gmail.com"]

  spec.summary       = %q{Use Selenium WebDriver to ease uploading files to Google Photos}
  spec.homepage      = "https://github.com/azuwis/ruby-gphotos"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_dependency 'selenium-webdriver'

  spec.add_development_dependency 'pry'
end
