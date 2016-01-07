require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "#favorite_merchant" do
    it "returns a merchant where the customer has conducted most successful transactions" do
      m1 = Merchant.create!(name: "Merchant1")
      m2 = Merchant.create!(name: "Merchant2")
      c = Customer.create!(first_name: "First Name",
                           last_name: "Last Name")

      create_invoices(c.id, m1.id, "shipped", 2)
      create_invoices(c.id, m2.id, "pending", 2)
      create_invoices(c.id, m2.id, "shipped", 1)

      fm = Customer.find(c.id).favorite_merchant

      expect(fm.id).to eq(m1.id)
    end
  end

  def create_invoices(customer_id, merchant_id, status, n)
    n.times do |n|
      i = Invoice.create!(customer_id: customer_id,
                          merchant_id: merchant_id,
                          status: status)
    end
  end
end
