require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do
  def create_invoices(n, customer_id, merchant_id)
    n.times do |n|
      Invoice.create!(customer_id: customer_id,
                      merchant_id: merchant_id,
                      status: "completed")
    end
  end

  describe "get #index" do
    it "returns all of the invoices" do
      m = Merchant.create!(name: "Name")
      c = Customer.create!(first_name: "First Name",
                           last_name:  "Last Name")
      create_invoices(3, c.id, m.id)

      get :index, format: :json
      expect(response.status).to eq(200)
      expect(response.body).to eq(Invoice.all.to_json)
    end
  end

  describe "get #show" do
    it "returns the invoice with given id" do
      m = Merchant.create!(name: "Merchant")
      c = Customer.create!(first_name: "First Name",
                           last_name:  "Last Name")
      i = Invoice.create!(customer_id: c.id,
                          merchant_id: m.id,
                          status: "completed")

      get :show, id: i.id, format: :json
      expect(response.status).to eq(200)
      expect(response.body).to eq(Invoice.find(i.id).to_json)
    end
  end

  describe "get /find" do
    it "returns the invoice with the given id" do
      i = Invoice.create!(status: "completed")

      get :show, id: "#{i.id}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Invoice.find(i.id).to_json)
    end

    it "returns the invoice with the given status" do
      status = "completed"
      i = Invoice.create!(status: status)

      get :show, status: "#{status}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Invoice.find_by(status: status).to_json)
    end
  end

  describe "get /find_all" do
    it "returns all of the invoices with the given status" do
      status = "completed"
      Invoice.create!(status: status)
      Invoice.create!(status: status)

      get :index, status: "#{status}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Invoice.where(status: status).to_json)
    end
  end

  describe "get #random" do
    it "returns a 'random' invoice" do
      i = Invoice.create!(status: "completed")
      Invoice.create!(status: "completed")
      allow(Invoice).to receive(:random) { i }

      get :random, format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Invoice.find(i.id).to_json)
    end
  end
end
