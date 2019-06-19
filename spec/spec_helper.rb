ENV['GOOGLE_API_KEY'] = 'test'
ENV['GOOGLE_SIGNING_SECRET'] = 'test'
ENV['GOOGLE_EMBEDDED_MAP_API_KEY'] = 'test'

require "bundler/setup"
require "tellus/google/client"
require "faker"
require "webmock/rspec"
require "support/web_stub/google"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
