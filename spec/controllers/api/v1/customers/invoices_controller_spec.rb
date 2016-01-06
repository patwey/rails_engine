require 'rails_helper'

RSpec.describe Api::V1::Customers::InvoicesController, type: :controller do
  describe "get #index" do
    it "responds to json" do
      c = Customer.create!(first_name: "Customer")
      Invoice.create!(customer_id: c.id)

      get :index, id: c.id, format: :json

      expect(response.status).to eq(200)
    end

    it "returns invoices for the customer with the given customer id" do
      c = Customer.create!(first_name: "Customer")
      Invoice.create!(customer_id: c.id)
      Invoice.create!(customer_id: c.id)

      get :index, id: c.id, format: :json

      expect(response.body).to eq(Customer.find(c.id).invoices.to_json)
    end
  end
end
