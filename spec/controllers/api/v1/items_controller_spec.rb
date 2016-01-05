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

  describe "get /find" do
    it "returns the item with the given id" do
      m = Merchant.create!(name: "Merchant")
      i = Item.create!(name:         "Item",
                       description:  "Description",
                       unit_price:   10.00,
                       merchant_id:  m.id)

      get :show, id: "#{i.id}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Item.find(i.id).to_json)
    end

    it "returns the item with the given name" do
      m = Merchant.create!(name: "Merchant")
      i = Item.create!(name:         "Item",
                       description:  "Description",
                       unit_price:   10.00,
                       merchant_id:  m.id)

      get :show, name: "#{i.name}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Item.find_by(name: i.name).to_json)
    end

    it "returns the item with the given description" do
      m = Merchant.create!(name: "Merchant")
      i = Item.create!(name:         "Item",
                       description:  "Description",
                       unit_price:   10.00,
                       merchant_id:  m.id)

      get :show, description: "#{i.description}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Item.find_by(description: i.description).to_json)
    end
  end

  describe "get /find_all" do
    it "returns all of the items with the given name" do
      m = Merchant.create!(name: "Merchant")
      i1 = Item.create!(name:         "My Item",
                        description:  "Description",
                        unit_price:   10.00,
                        merchant_id:  m.id)
      i2 = Item.create!(name:         "My Item",
                        description:  "Description",
                        unit_price:   10.00,
                        merchant_id:  m.id)

      get :index, name: "#{i1.name}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Item.where(name: i1.name).to_json)
    end

    it "returns all of the items with the given description" do
      m = Merchant.create!(name: "Merchant")
      i1 = Item.create!(name:         "The Item",
                        description:  "A Description",
                        unit_price:   10.00,
                        merchant_id:  m.id)
      i2 = Item.create!(name:         "My Item",
                        description:  "A Description",
                        unit_price:   10.00,
                        merchant_id:  m.id)

      get :index, description: "#{i1.description}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Item.where(description: i1.description).to_json)
    end

    it "returns all of the items with the given unit_price" do
      m = Merchant.create!(name: "Merchant")
      i1 = Item.create!(name:         "The Item",
                        description:  "A Long Description",
                        unit_price:   10.00,
                        merchant_id:  m.id)
      i2 = Item.create!(name:         "My Item",
                        description:  "A Description",
                        unit_price:   10.00,
                        merchant_id:  m.id)

      get :index, unit_price: "#{i1.unit_price}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Item.where(unit_price: i1.unit_price).to_json)
    end

    it "returns all of the items with the given merchant_id" do
      m = Merchant.create!(name: "Merchant")
      i1 = Item.create!(name:         "The Item",
                        description:  "A Description",
                        unit_price:   10.00,
                        merchant_id:  m.id)
      i2 = Item.create!(name:         "My Item",
                        description:  "A Description",
                        unit_price:   10.00,
                        merchant_id:  m.id)

      get :index, merchant_id: "#{i1.merchant_id}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Item.where(merchant_id: i1.merchant_id).to_json)
    end
  end

  describe "get /random" do
    it "returns a 'random' item" do
      m = Merchant.create!(name: "Merchant")
      i1 = Item.create!(name:         "The Item",
                        description:  "A Description",
                        unit_price:   10.00,
                        merchant_id:  m.id)
      i2 = Item.create!(name:         "My Item",
                        description:  "A Description",
                        unit_price:   10.00,
                        merchant_id:  m.id)
      allow(Item).to receive(:random) { i1 }

      get :show, random: "random", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Item.find(i1.id).to_json)
    end
  end
end
