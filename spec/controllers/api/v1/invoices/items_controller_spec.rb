require 'rails_helper'

RSpec.describe Api::V1::Invoices::ItemsController, type: :controller do
  describe "get #index" do
    it "responds to json" do
      item = Item.create!(unit_price: 100)
      invoice = Invoice.create!(status: "complete")
      InvoiceItem.create!(item_id: item.id,
                          unit_price: item.unit_price,
                          invoice_id: invoice.id)

      get :index, id: invoice.id, format: :json

      expect(response.status).to eq(200)
    end

    xit "returns items for the invoice with the given invoice id" do
      item = Item.create!(unit_price: 100)
      item2 = Item.create!(unit_price: 200)
      invoice = Invoice.create!(status: "complete")
      InvoiceItem.create!(item_id: item.id,
                          unit_price: item.unit_price,
                          invoice_id: invoice.id)
      InvoiceItem.create!(item_id: item2.id,
                          unit_price: item2.unit_price,
                          invoice_id: invoice.id)

      get :index, id: invoice.id, format: :json

      expect(response.body).to eq(Invoice.find(invoice.id).items.to_json)
    end
  end
end
