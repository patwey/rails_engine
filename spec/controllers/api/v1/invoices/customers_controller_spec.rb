require 'rails_helper'

RSpec.describe Api::V1::Invoices::CustomersController, type: :controller do
  describe "get #show" do
    it "responds to json" do
      c = Customer.create!(first_name: "Customer")
      i = Invoice.create!(customer_id: c.id)

      get :show, id: i.id, format: :json

      expect(response.status).to eq(200)
    end

    it "returns the customer for the invoice with the given invoice id" do
      c = Customer.create!(first_name: "Customer")
      i = Invoice.create!(customer_id: c.id)

      get :show, id: i.id, format: :json

      expect(response.body).to eq(Customer.find(c.id).to_json)
    end
  end
end
