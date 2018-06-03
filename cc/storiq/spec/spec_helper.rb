require 'simplecov'
SimpleCov.start

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.order = :random

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.filter_run_when_matching :focus

  Kernel.srand config.seed

  config.disable_monkey_patching!

  config.profile_examples = 5

end

def json_response
  JSON.parse(response.body)
end

def html_response
  Nokogiri::XML(response.body)
end
