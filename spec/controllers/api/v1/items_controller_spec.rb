require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  def create_items(n, merchant_id)
    n.times do |n|
      Item.create!(name:        "Name #{n}",
                   description: "Description #{n}",
                   unit_price:  100.00,
                   merchant_id: merchant_id)
    end
  end

  describe "get #index" do
    it "returns all of the items" do
      m = Merchant.create(name: "Name")
      create_items(3, m.id)

      get :index, format: :json
      expect(response.status).to eq(200)
      expect(response.body).to eq(Item.all.to_json)
    end
  end

  describe "get #show" do
    it "returns the item with given id" do
      m = Merchant.create!(name: "Merchant")
      i = Item.create!(name:        "Name",
                       description: "Description",
                       unit_price:  100.00,
                       merchant_id: m.id)

      get :show, id: i.id, format: :json
      expect(response.status).to eq(200)
      expect(response.body).to eq(Item.find(i.id).to_json)
    end
  end
end
