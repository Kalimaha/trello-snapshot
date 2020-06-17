require_relative 'lib/trello/tools/version'

Gem::Specification.new do |spec|
  spec.name          = "trello-tools"
  spec.version       = Trello::Tools::VERSION
  spec.authors       = ["Kalimaha"]
  spec.email         = ["guido.barbaglia@gmail.com"]

  spec.summary       = "This is the summary"
  spec.description   = "This is the description"
  spec.homepage      = "http://example.com/"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "This is the allowed_push_host"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://example.com/"
  spec.metadata["changelog_uri"] = "http://example.com/"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
