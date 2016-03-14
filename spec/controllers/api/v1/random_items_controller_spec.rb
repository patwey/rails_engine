require 'rails_helper'

RSpec.describe Api::V1::RandomItemsController, type: :controller do
  describe "get #show" do
    it "responds to json" do
      Item.create!(name: "Item",
                   unit_price: 100)

      get :show, format: :json

      expect(response.status).to eq(200)
    end

    it "returns one item" do
      Item.create!(name: "Item1",
                   unit_price: 100)
      Item.create!(name: "Item2",
                   unit_price: 100)

      get :show, format: :json

      expect(parsed_body.class).to eq(Hash)
    end

    def parsed_body
      JSON.parse(response.body)
    end
  end
end
