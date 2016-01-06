require 'rails_helper'

RSpec.describe Api::V1::Merchants::InvoicesController, type: :controller do
  describe "get #index" do
    it "responds to json" do
      m = Merchant.create!(name: "Merchant")
      i = Invoice.create!(merchant_id: m.id)
      get :index, id: m.id, format: :json

      expect(response.status).to eq(200)
    end

    it "returns the invoices with the given merchant id" do
      m = Merchant.create!(name: "Merchant")
      i1 = Invoice.create!(merchant_id: m.id)
      i2 = Invoice.create!(merchant_id: m.id)

      get :index, id: m.id, format: :json

      expect(response.body).to eq(Invoice.where(merchant_id: m.id).to_json)
    end
  end
end
