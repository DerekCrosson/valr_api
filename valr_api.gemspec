# frozen_string_literal: true

require_relative "lib/valr_api/version"

Gem::Specification.new do |spec|
  spec.name = "valr_api"
  spec.version = ValrApi::VERSION
  spec.authors = ["Derek Crosson"]
  spec.email = ["derekcrosson18@gmail.com"]

  spec.summary = "A Ruby wrapper for the VALR API."
  spec.description = "A Ruby wrapper for the VALR API."
  spec.homepage = "http://github.com/DerekCrosson/valr_api"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://github.com/DerekCrosson/valr_api"
  spec.metadata["changelog_uri"] = "https://github.com/DerekCrosson/valr_api/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency 'httparty', '~> 0.18'
  spec.add_development_dependency 'webmock', '~> 3.14'
  spec.add_dependency 'faye-websocket', '~> 0.10'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
