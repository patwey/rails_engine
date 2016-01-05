require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do
  def create_transactions(n, invoice_id)
    n.times do |n|
      # remove create_card_expiration_date
      # create_card_number_as_string
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
end
