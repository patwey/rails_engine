require 'rails_helper'

RSpec.describe Api::V1::RandomInvoicesController, type: :controller do
  describe "get #show" do
    it "responds to json" do
      Invoice.create!(status: "shipped")

      get :show, format: :json

      expect(response.status).to eq(200)
    end

    it "returns one invoice" do
      Invoice.create!(status: "shipped")
      Invoice.create!(status: "pending")

      get :show, format: :json

      expect(parsed_body.class).to eq(Hash)
    end

    def parsed_body
      JSON.parse(response.body)
    end
  end
end
