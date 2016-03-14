require 'rails_helper'

RSpec.describe Api::V1::RandomTransactionsController, type: :controller do
  describe "get #show" do
    it "responds to json" do
      Transaction.create!(result: "success")

      get :show, format: :json

      expect(response.status).to eq(200)
    end

    it "returns one transaction" do
      Transaction.create!(result: "success")
      Transaction.create!(result: "failure")

      get :show, format: :json

      expect(parsed_body.class).to eq(Hash)
    end

    def parsed_body
      JSON.parse(response.body)
    end
  end
end
