require 'rails_helper'

RSpec.describe Api::V1::Invoices::MerchantsController, type: :controller do
  describe "get #show" do
    it "responds to json" do
      m = Merchant.create!(name: "Merchant")
      i = Invoice.create!(merchant_id: m.id)

      get :show, id: i.id, format: :json

      expect(response.status).to eq(200)
    end

    it "returns the merchant for the invoice with the given invoice id" do
      m = Merchant.create!(name: "Merchant")
      i = Invoice.create!(merchant_id: m.id)

      get :show, id: i.id, format: :json

      expect(response.body).to eq(Invoice.find(i.id).merchant.to_json)
    end
  end
end
