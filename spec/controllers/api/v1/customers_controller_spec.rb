require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do
  def create_customers(n)
    n.times do |n|
      Customer.create!(first_name: "First #{n}",
                       last_name:  "Last #{n}")
    end
  end

  describe "get #index" do
    it "returns all of the customers" do
      create_customers(3)

      get :index, format: :json
      expect(response.status).to eq(200)
      expect(response.body).to eq(Customer.all.to_json)
    end
  end

  describe "get #show" do
    it "returns the customer with given id" do
      c = Customer.create!(first_name: "First",
                           last_name:  "Last")

      get :show, id: c.id, format: :json
      expect(response.status).to eq(200)
      expect(response.body).to eq(Customer.find(c.id).to_json)
    end
  end
end
