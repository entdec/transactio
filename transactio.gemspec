require_relative 'lib/transactio/version'

Gem::Specification.new do |spec|
  spec.name          = "transactio"
  spec.version       = Transactio::VERSION
  spec.authors       = ["Tom de Grunt"]
  spec.email         = ["tom@degrunt.nl"]

  spec.summary       = %q{Within one transaction, track changes to your models and see all state transitions.}
  spec.description    = %q{Within one transaction, track changes to your models and see all state transitions.}
  spec.homepage      = "https://code.entropydecelerator.com/components/transactio"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://code.entropydecelerator.com/components/transactio"
  spec.metadata["changelog_uri"] = "https://code.entropydecelerator.com/components/transactio"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 6"

  spec.add_development_dependency 'auxilium', '~> 0.2'
end
