# frozen_string_literal: true

require_relative "lib/algonquin_stocks/version"

Gem::Specification.new do |s|
  s.name          = "algonquin_stocks"
  s.version       = AlgonquinStocks::VERSION
  s.authors       = ["Andrei Grobnic"]
  s.email         = ["andrey.grobnik@gmail.com"]
  s.license       = "GPL-2.0"
  s.summary       = "Stocks"
  s.description   = "A gem for retrieving stock information"
  s.homepage      = "https://github.com/andreigrob/stocks"
  s.required_ruby_version = ">= 3.1.0"

  s.metadata = {
    "allowed_push_host" => "https://rubygems.org",
    "homepage_uri" => "https://github.com/andreigrob/stocks",
    "source_code_uri" => "https://github.com/andreigrob/stocks"
  }

  # Simple file specification to avoid packaging issues
  s.files         = Dir["lib/**/*.rb", "README.md"]
  s.bindir        = "exe"
  s.executables   = Dir["exe/*"].map { |f| File.basename(f) }
  s.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
