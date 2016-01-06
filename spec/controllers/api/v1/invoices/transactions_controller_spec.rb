require 'rails_helper'

RSpec.describe Api::V1::Invoices::TransactionsController, type: :controller do
  describe "get #index" do
    it "responds to json" do
      i = Invoice.create!(status: "completed")
      t = Transaction.create!(invoice_id: i.id)

      get :index, id: i.id, format: :json

      expect(response.status).to eq(200)
    end

    it "returns transactions for the invoice with the given invoice id" do
      i = Invoice.create!(status: "completed")
      t = Transaction.create!(invoice_id: i.id)
      t2 = Transaction.create!(invoice_id: i.id)

      get :index, id: i.id, format: :json

      expect(response.body).to eq(Transaction.where(invoice_id: i.id).to_json)
    end
  end
end
