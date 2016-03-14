require 'rails_helper'

RSpec.describe Api::V1::RandomInvoiceItemsController, type: :controller do
  describe "get #show" do
    it "responds to json" do
      InvoiceItem.create!(unit_price: 100)

      get :show, format: :json

      expect(response.status).to eq(200)
    end

    it "returns one invoice item" do
      InvoiceItem.create!(unit_price: 100)
      InvoiceItem.create!(unit_price: 200)

      get :show, format: :json

      expect(parsed_body.class).to eq(Hash)
    end

    def parsed_body
      JSON.parse(response.body)
    end
  end
end
