# frozen_string_literal: true

require 'simplecov'
SimpleCov.minimum_coverage 97
SimpleCov.start

RSpec.configure do |config|
  require 'byebug'

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
