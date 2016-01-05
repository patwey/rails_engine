require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do
  def create_merchants(n)
    n.times do |n|
      Merchant.create!(name: "Name #{n}")
    end
  end

  describe "get #index" do
    it "returns all of the merchants" do
      create_merchants(3)

      get :index, format: :json
      expect(response.status).to eq(200)
      expect(response.body).to eq(Merchant.all.to_json)
    end
  end

  describe "get #show" do
    it "returns the merchant with given id" do
      m = Merchant.create!(name: "Name")

      get :show, id: m.id, format: :json
      expect(response.status).to eq(200)
      expect(response.body).to eq(Merchant.find(m.id).to_json)
    end
  end
end
