require 'rails_helper'

RSpec.describe Api::V1::InvoiceItems::ItemsController, type: :controller do
  describe "get #show" do
    it "responds to json" do
      item = Item.create!(unit_price: 100)
      ii = InvoiceItem.create!(item_id: item.id,
                               unit_price: item.unit_price)

      get :show, id: ii.id, format: :json

      expect(response.status).to eq(200)
    end

    it "returns the item for the invoice item with the given invoice item id" do
      item = Item.create!(unit_price: 100)
      ii = InvoiceItem.create!(item_id: item.id,
                               unit_price: item.unit_price)

      get :show, id: ii.id, format: :json

      expect(response.body).to eq(InvoiceItem.find(ii.id).item.to_json)
    end
  end
end
