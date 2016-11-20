# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Redirect stdout and stderr during rspec runs so their output doesn't show up in the results. 
  original_stderr = $stderr
  config.before(:all) do
    # Redirect stderr and stdout
    $stderr = File.open(File::NULL, "w")
  end
  config.after(:all) do
    $stderr = original_stderr
  end
end
