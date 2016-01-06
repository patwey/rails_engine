require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController, type: :controller do
  def create_invoice_items(n, item, invoice_id)
    n.times do |n|
      InvoiceItem.create!(item_id: item.id,
                          invoice_id: invoice_id,
                          quantity: 3,
                          unit_price: item.unit_price)
    end
  end

  describe "get #index" do
    it "returns all of the invoice items" do
      m = Merchant.create!(name: "Name")
      item = Item.create!(name: "Item1",
                          description: "Description",
                          unit_price: 10.00,
                          merchant_id: m.id)
      c = Customer.create!(first_name: "First Name",
                           last_name:  "Last Name")
      invoice = Invoice.create!(customer_id: c.id,
                                merchant_id: m.id,
                                status:      "completed")
      create_invoice_items(3, item, invoice.id)

      get :index, format: :json
      expect(response.status).to eq(200)
      expect(response.body).to eq(InvoiceItem.all.to_json)
    end
  end

  describe "get #show" do
    it "returns the invoice item with given id" do
      m = Merchant.create!(name: "Merchant")
      item = Item.create!(name: "Item1",
                          description: "Description",
                          unit_price: 10.00,
                          merchant_id: m.id)
      c = Customer.create!(first_name: "First Name",
                           last_name:  "Last Name")
      invoice = Invoice.create!(customer_id: c.id,
                          merchant_id: m.id,
                          status: "completed")
      i = InvoiceItem.create!(item_id: item.id,
                          invoice_id: invoice.id,
                          quantity: 3,
                          unit_price: item.unit_price)

      get :show, id: i.id, format: :json
      expect(response.status).to eq(200)
      expect(response.body).to eq(InvoiceItem.find(i.id).to_json)
    end
  end

  describe "get /find" do
    it "returns the invoice item with the given id" do
      i = InvoiceItem.create(unit_price: 100)

      get :show, id: "#{i.id}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(InvoiceItem.find(i.id).to_json)
    end

    it "returns the invoice item with the given item_id" do
      item = Item.create!(unit_price: 100)
      i = InvoiceItem.create(unit_price: item.unit_price,
                             item_id: item.id)

      get :show, item_id: "#{item.id}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(InvoiceItem.find_by(item_id: item.id).to_json)
    end

    it "returns the invoice item with the given invoice_id" do
      invoice = Invoice.create!(status: "completed")
      i = InvoiceItem.create(unit_price: 100,
                             invoice_id: invoice.id)

      get :show, invoice_id: "#{invoice.id}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(InvoiceItem.find_by(invoice_id: invoice.id).to_json)
    end

    it "returns the invoice item with the given quantity" do
      quantity = 1
      i = InvoiceItem.create!(unit_price: 100,
                             quantity: quantity)

      get :show, quantity: "#{quantity}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(InvoiceItem.find_by(quantity: quantity).to_json)
    end
  end

  describe "get /find_all" do
    it "returns all of the invoice items with the given quantity" do
      quantity = 1
      i = InvoiceItem.create!(unit_price: 100,
                              quantity: quantity)

      get :index, quantity: "#{quantity}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(InvoiceItem.where(quantity: quantity).to_json)
    end
  end

  describe "get #random" do
    it "returns a 'random' invoice item" do
      ii1 = InvoiceItem.create!(unit_price: 100)
      InvoiceItem.create!(unit_price: 200)
      allow(InvoiceItem).to receive(:random) { ii1 }

      get :random, format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(InvoiceItem.find(ii1.id).to_json)
    end
  end

end
