require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "#favorite_customer" do
    it "returns a customer where the merchant has conducted most successful transactions" do
      c1 = Customer.create!(first_name: "Customer1")
      c2 = Customer.create!(first_name: "Customer2")
      m = Merchant.create!(name: "Merchant")

      create_invoices(c1.id, m.id, "shipped", 2)
      create_invoices(c2.id, m.id, "pending", 2)
      create_invoices(c2.id, m.id, "shipped", 1)

      fc = Merchant.find(m.id).favorite_customer

      expect(fc.id).to eq(c1.id)
    end
  end

  describe "#total_revenue" do
    it "returns the total revenue for that merchant across all successful transactions" do
      m = Merchant.create!(name: "Merchant")

      create_100_dollar_transaction(m.id, "success")
      create_100_dollar_transaction(m.id, "failed")

      revenue = Merchant.find(m.id).total_revenue

      expect(revenue).to eq({"revenue" => 100})
    end
  end

  def create_100_dollar_transaction(merchant_id, result)
    i = Invoice.create!(merchant_id: merchant_id)
    InvoiceItem.create!(invoice_id: i.id,
                        unit_price:  1000,
                        quantity:    10)
    Transaction.create!(invoice_id: i.id,
                        result: result)
  end
end
