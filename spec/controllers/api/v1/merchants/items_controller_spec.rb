require 'rails_helper'

RSpec.describe Api::V1::Merchants::ItemsController, type: :controller do
  describe "get #index" do
    it "responds to json" do
      m = Merchant.create!(name: "Merchant")
      i = Item.create!(merchant_id: m.id,
                       unit_price: 100)
      get :index, id: m.id, format: :json

      expect(response.status).to eq(200)
    end

    it "returns the items with the given merchant id" do
      m = Merchant.create!(name: "Merchant")
      i1 = Item.create!(merchant_id: m.id,
                        unit_price: 100)
      i2 = Item.create!(merchant_id: m.id,
                        unit_price: 100)

      get :index, id: m.id, format: :json

      expect(response.body).to eq(Item.where(merchant_id: m.id).to_json)
    end
  end
end
