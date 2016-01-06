require 'rails_helper'

RSpec.describe Api::V1::Invoices::InvoiceItemsController, type: :controller do
  describe "get #index" do
    it "responds to json" do
      invoice = Invoice.create!(status: "complete")
      ii = InvoiceItem.create!(invoice_id: invoice.id,
                               unit_price: 100)

      get :index, id: invoice.id, format: :json

      expect(response.status).to eq(200)
    end

    it "returns the invoice items for the invoice with the given invoice id" do
      invoice = Invoice.create!(status: "complete")
      ii = InvoiceItem.create!(invoice_id: invoice.id,
                               unit_price: 100)
      ii2 = InvoiceItem.create!(invoice_id: invoice.id,
                                unit_price: 200)

      get :index, id: invoice.id, format: :json

      expect(response.body).to eq(Invoice.find(invoice.id).invoice_items.to_json)
    end
  end
end
