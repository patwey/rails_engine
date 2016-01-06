require 'rails_helper'

RSpec.describe Api::V1::InvoiceItems::InvoicesController, type: :controller do
  describe "get #show" do
    it "responds to json" do

      get :show, id: i.id, format: :json

      expect(response.status).to eq(200)
    end

    xit "returns transactions for the invoice with the given invoice id" do

      get :show, id: i.id, format: :json

      expect(response.body).to eq(Transaction.where(invoice_id: i.id).to_json)
    end
  end
end
