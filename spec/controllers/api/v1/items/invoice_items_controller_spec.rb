require 'rails_helper'

RSpec.describe Api::V1::Items::InvoiceItemsController, type: :controller do
  describe "get #index" do
    it "responds to json" do
      item = Item.create!(unit_price: 100)
      ii = InvoiceItem.create!(item_id: item.id,
                               unit_price: item.unit_price)
      get :index, id: item.id, format: :json

      expect(response.status).to eq(200)
    end

    it "returns the invoice items with the given item id" do
      item = Item.create!(unit_price: 100)
      ii = InvoiceItem.create!(item_id: item.id,
                               unit_price: item.unit_price)
      ii = InvoiceItem.create!(item_id: item.id,
                               unit_price: item.unit_price)

      get :index, id: item.id, format: :json

      expect(response.body).to eq(InvoiceItem.where(item_id: item.id).to_json)
    end
  end
end
