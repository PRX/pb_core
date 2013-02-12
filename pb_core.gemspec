# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pb_core/version'

Gem::Specification.new do |gem|
  gem.name          = "pb_core"
  gem.version       = PBCore::VERSION
  gem.authors       = ["Andrew Kuklewicz"]
  gem.email         = ["andrew@prx.org"]
  gem.description   = %q{Gem for working with PBCore 2.0 XML data}
  gem.summary       = %q{Gem for working with PBCore 2.0 XML data}
  gem.homepage      = "https://github.com/PRX/pb_core"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'sax-machine'

  gem.add_development_dependency 'rake'

end
