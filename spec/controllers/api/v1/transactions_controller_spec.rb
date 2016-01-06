require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do
  def create_transactions(n, invoice_id)
    n.times do |n|
      Transaction.create!(invoice_id:         invoice_id,
                          credit_card_number: "1234567891234567",
                          result:             "success")
    end
  end

  describe "get #index" do
    it "returns all of the transactions" do
      m = Merchant.create!(name: "Name")
      c = Customer.create!(first_name: "First Name",
                           last_name:  "Last Name")
      i = Invoice.create!(customer_id: c.id,
                          merchant_id: m.id,
                          status: "completed")
      create_transactions(3, i.id)

      get :index, format: :json
      expect(response.status).to eq(200)
      expect(response.body).to eq(Transaction.all.to_json)
    end
  end

  describe "get #show" do
    it "returns the transaction with given id" do
      m = Merchant.create!(name: "Merchant")
      c = Customer.create!(first_name: "First Name",
                           last_name:  "Last Name")
      i = Invoice.create!(customer_id: c.id,
                          merchant_id: m.id,
                          status: "completed")
      t = Transaction.create!(invoice_id:         i.id,
                              credit_card_number: "1234567891234567",
                              result:             "success")

      get :show, id: t.id, format: :json
      expect(response.status).to eq(200)
      expect(response.body).to eq(Transaction.find(t.id).to_json)
    end
  end

  describe "get /find" do
    it "returns the transaction with the given id" do
      t = Transaction.create!(result: "success")

      get :show, id: "#{t.id}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Transaction.find(t.id).to_json)
    end

    it "returns the transaction with the given credit_card_number" do
      cc_number = "1234567891234567"
      t = Transaction.create!(credit_card_number: cc_number)

      get :show, credit_card_number: "#{cc_number}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Transaction.find_by(credit_card_number: cc_number).to_json)
    end
  end

  describe "get /find_all" do
    it "returns all of the transactions with the given result" do
      result = "success"
      Transaction.create!(result: result)
      Transaction.create!(result: result)

      get :index, result: "#{result}", format: :json

      expect(response.status).to eq(200)
      expect(response.body).to eq(Transaction.where(result: result).to_json)
    end
  end
end
