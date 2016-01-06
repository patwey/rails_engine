require 'rails_helper'

RSpec.describe Api::V1::Transactions::InvoicesController, type: :controller do
  describe "get #show" do
    it "responds to json" do
      i = Invoice.create!(status: "complete")
      t = Transaction.create!(invoice_id: i.id)
      get :show, id: t.id, format: :json

      expect(response.status).to eq(200)
    end

    it "returns the invoice with associated with the transaction id" do
      i = Invoice.create!(status: "complete")
      t = Transaction.create!(invoice_id: i.id)
      get :show, id: t.id, format: :json

      expect(response.body).to eq(Invoice.find(i.id).to_json)
    end
  end
end
