require 'rails_helper'

RSpec.describe Api::V1::Customers::TransactionsController, type: :controller do
  describe "get #index" do
    xit "responds to json" do
      # create stuff

      get :index, id: c.id, format: :json

      expect(response.status).to eq(200)
    end

    xit "returns transactions for the customer with the given customer id" do
      # create stuff

      get :index, id: c.id, format: :json

      expect(response.body).to eq(Customer.find(c.id).invoices.to_json)
    end
  end
end
