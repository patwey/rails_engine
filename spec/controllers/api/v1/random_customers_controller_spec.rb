require 'rails_helper'

RSpec.describe Api::V1::RandomCustomersController, type: :controller do
  describe "get #show" do
    it "responds to json" do
      Customer.create!(first_name: "Customer")

      get :show, format: :json

      expect(response.status).to eq(200)
    end

    it "returns one customer" do
      Customer.create!(first_name: "Customer1")
      Customer.create!(first_name: "Customer2")

      get :show, format: :json

      expect(parsed_body.class).to eq(Hash)
    end

    def parsed_body
      JSON.parse(response.body)
    end
  end
end
