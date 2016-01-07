require 'simplecov'
SimpleCov.start

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  def create_invoices(customer_id, merchant_id, status, n)
    n.times do |n|
      i = Invoice.create!(customer_id: customer_id,
                          merchant_id: merchant_id,
                          status: status)
    end
  end
end
