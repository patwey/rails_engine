require 'rails_helper'

RSpec.describe Api::V1::Customers::TransactionsController, type: :controller do
  describe "get #index" do
    it "responds to json" do
      c = Customer.create!(first_name: "Customer")
      i = Invoice.create!(customer_id: c.id)
      Transaction.create!(invoice_id: i.id)

      get :index, id: c.id, format: :json

      expect(response.status).to eq(200)
    end

    it "returns transactions for the customer with the given customer id" do
      c = Customer.create!(first_name: "Customer")
      i = Invoice.create!(customer_id: c.id)
      i2 = Invoice.create!(customer_id: c.id)
      Transaction.create!(invoice_id: i.id)
      Transaction.create!(invoice_id: i2.id)

      get :index, id: c.id, format: :json

      expect(response.body).to eq(Customer.find(c.id).transactions.to_json)
    end
  end
end
