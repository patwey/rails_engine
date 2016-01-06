require 'rails_helper'

RSpec.describe Api::V1::Items::MerchantsController, type: :controller do
  describe "get #show" do
    it "responds to json" do
      m = Merchant.create!(name: "Merchant")
      item = Item.create!(unit_price: 100,
                          merchant_id: m.id)

      get :show, id: item.id, format: :json

      expect(response.status).to eq(200)
    end

    it "returns the merchant for the item with the given item id" do
      m = Merchant.create!(name: "Merchant")
      item = Item.create!(unit_price: 100,
                          merchant_id: m.id)

      get :show, id: item.id, format: :json

      expect(response.body).to eq(Item.find(item.id).merchant.to_json)
    end
  end
end
