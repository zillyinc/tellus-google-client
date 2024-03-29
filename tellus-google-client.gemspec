
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tellus/google/client/version"

Gem::Specification.new do |spec|
  spec.name          = "tellus-google-client"
  spec.version       = Tellus::Google::Client::VERSION
  spec.authors       = ["Calvin Tuong"]
  spec.email         = ["calvin@tellusapp.com"]

  spec.summary       = %q{Client for various Google APIs.}
  spec.homepage      = "https://github.com/zillyinc/tellus-google-client"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = ''

    spec.metadata["homepage_uri"] = spec.homepage
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.17"
  spec.add_dependency "activesupport", "~> 6.0"

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.9"
  spec.add_development_dependency "faker", "~> 2.10"
  spec.add_development_dependency "webmock", "~> 3.8"
end
