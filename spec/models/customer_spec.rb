require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "#favorite_merchant" do
    it "returns a merchant where the customer has conducted most successful transactions" do
      m1 = Merchant.create!(name: "Merchant1")
      m2 = Merchant.create!(name: "Merchant2")
      c = Customer.create!(first_name: "First Name",
                           last_name: "Last Name")

      create_transactions(c.id, m1.id, "success", 2)
      create_transactions(c.id, m2.id, "failed", 2)
      create_transactions(c.id, m2.id, "success", 1)

      fm = Customer.favorite_merchant(c.id)

      expect(fm.id).to eq(m1.id)
    end
  end

  def create_transactions(customer_id, merchant_id, result, n)
    n.times do |n|
      i = Invoice.create!(customer_id: customer_id,
                          merchant_id: merchant_id)
      Transaction.create!(invoice_id: i.id,
                          result: result)
    end
  end
end
