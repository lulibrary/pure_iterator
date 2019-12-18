
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pure_iterator/version"

Gem::Specification.new do |spec|
  spec.name          = "pure_iterator"
  spec.version       = PureIterator::VERSION
  spec.authors       = ["Adrian Albin-Clark"]
  spec.email         = ["a.albin-clark@lancaster.ac.uk"]
  spec.summary       = %q{A flexible way to process records in the Pure Research Information System.}
  spec.metadata = {
    'source_code_uri' => "https://github.com/lulibrary/#{spec.name}",
    "documentation_uri" => "https://www.rubydoc.info/gems/#{spec.name}/#{spec.version}",
  }
  spec.license       = "MIT"
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'minitest-reporters', '~> 1.1'

  spec.add_dependency 'http', '~> 4.0'
  spec.add_dependency 'nokogiri', '~> 1.6'
end
