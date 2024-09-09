require 'simplecov'

SimpleCov.start 'rails' do
  add_filter %w[
    app/views
    app/channels
    app/jobs
    app/mailers
    app/controllers/turbo_devise_controller.rb
    lib/rails 
    lib/templates
    bin 
    coverage 
    log 
    test 
    vendor 
    node_modules 
    db 
    doc   
    public 
    storage 
    tmp
  ]

  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
end

SimpleCov.coverage_dir 'public/coverage'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
