require 'rails_helper'

RSpec.describe Api::V1::InvoiceItems::InvoicesController, type: :controller do
  describe "get #show" do
    it "responds to json" do
      invoice = Invoice.create!(status: "completed")
      ii = InvoiceItem.create!(invoice_id: invoice.id,
                               unit_price: 100)

      get :show, id: ii.id, format: :json

      expect(response.status).to eq(200)
    end

    it "returns the invoice for the invoice with the given invoice item id" do
      invoice = Invoice.create!(status: "completed")
      ii = InvoiceItem.create!(invoice_id: invoice.id,
                               unit_price: 100)

      get :show, id: ii.id, format: :json

      expect(response.body).to eq(InvoiceItem.find(ii.id).invoice.to_json)
    end
  end
end
