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

  describe "get /find" do
    it "returns the customer with the given id" do
      c = Customer.create!(first_name: "First",
                           last_name:  "Last")

      get :show, id: "#{c.id}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Customer.find(c.id).to_json)
    end

    it "returns the customer with the given first name" do
      c = Customer.create!(first_name: "First",
                           last_name:  "Last")


      get :show, first_name: "#{c.first_name}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Customer.find_by(first_name: c.first_name).to_json)
    end

    it "returns the customer with the given last name" do
      c = Customer.create!(first_name: "First",
                           last_name:  "Last")


      get :show, last_name: "#{c.last_name}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Customer.find_by(last_name: c.last_name).to_json)
    end
  end

  describe "get /find_all" do
    it "returns all of the customers with the given first name" do
      m1 = Customer.create!(first_name: "First")
      m2 = Customer.create!(first_name: "First", created_at: "2012-03-27 14:53:59 UTC")

      get :index, first_name: "#{m1.first_name}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Customer.where(first_name: m1.first_name).to_json)
    end

    it "returns all of the customers with the given last name" do
      m1 = Customer.create!(last_name: "First")
      m2 = Customer.create!(last_name: "First", created_at: "2012-03-27 14:53:59 UTC")

      get :index, last_name: "#{m1.last_name}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Customer.where(last_name: m1.last_name).to_json)
    end
  end

  describe "get /random" do
    xit "returns a 'random' merchant" do
      m1 = Customer.create!(first_name: "First Name1")
      m2 = Customer.create!(first_name: "First Name2")
      allow(Customer).to receive(:random) { m1 }

      get :show, random: "random", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Customer.find(m1.id).to_json)
    end
  end
end
