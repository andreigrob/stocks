# frozen_string_literal: true

require_relative "lib/stocks/version"

Gem::Specification.new do |spec|
  spec.name = "stocks"
  spec.version = Stocks::VERSION
  spec.authors = ["Andrei Grobnic"]
  spec.email = ["grobnia@algonquincollege.com"]
  spec.license = "GPL-2.0"

  spec.summary = "Stocks"
  spec.description = "A gem for managing stocks"
  spec.homepage = "https://github.com/andreigrob/stocks"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/andreigrob/stocks"

  spec.files = Dir.glob("{lib,exe}/**/*") + %w[README.md]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
