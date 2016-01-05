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

  describe "get /find" do
    it "returns the merchant with the given id" do
      m = Merchant.create!(name: "Name")

      get :show, id: "#{m.id}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Merchant.find(m.id).to_json)
    end

    it "returns the merchant with the given name" do
      m = Merchant.create!(name: "Name")

      get :show, name: "#{m.name}", format: :json
      expect(response.status).to eq(200)
      expect(response.body).to eq(Merchant.find_by(name: m.name).to_json)
    end
  end

  describe "get /find_all" do
    it "returns all of the merchants with the given name" do
      m1 = Merchant.create!(name: "Name")
      m2 = Merchant.create!(name: "Name", created_at: "2012-03-27 14:53:59 UTC")

      get :index, name: "#{m1.name}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Merchant.where(name: m1.name).to_json)
    end
  end

  describe "get /random" do
    it "returns a 'random' merchant" do
      m1 = Merchant.create!(name: "Name1")
      m2 = Merchant.create!(name: "Name2")
      allow(Merchant).to receive(:random) { m1 }

      get :show, random: "random", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Merchant.find(m1.id).to_json)
    end
  end
end
