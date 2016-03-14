require 'rails_helper'

RSpec.describe Api::V1::RandomMerchantsController, type: :controller do
  describe "get #show" do
    it "responds to json" do
      Merchant.create!(name: "Merchant")

      get :show, format: :json

      expect(response.status).to eq(200)
    end

    it "returns one merchant" do
      Merchant.create!(name: "Merchant1")
      Merchant.create!(name: "Merchant2")

      get :show, format: :json

      expect(parsed_body.class).to eq(Hash)
    end

    def parsed_body
      JSON.parse(response.body)
    end
  end
end
