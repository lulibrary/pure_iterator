
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pure_iterator/version"

Gem::Specification.new do |spec|
  spec.name          = "pure_iterator"
  spec.version       = PureIterator::VERSION
  spec.authors       = ["Adrian Albin-Clark"]
  spec.email         = ["a.albin-clark@lancaster.ac.uk"]

  spec.summary       = %q{A flexible way to access records in the Pure Research Information System.}
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'minitest-reporters', '~> 1.1'

  spec.add_dependency 'http', '~> 3.0'
  spec.add_dependency 'nokogiri', '~> 1.6'
end