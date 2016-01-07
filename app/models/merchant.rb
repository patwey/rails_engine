class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices

  default_scope -> { order('id DESC') }

  def self.by_most_revenue(n)
    self.all
        .sort_by { |m| m.total_revenue["revenue"].to_f }
        .reverse
        .first(n)
  end


  def favorite_customer
    favorite_customer_id = self.invoices.where(status: "shipped")
                               .group(:customer_id)
                               .count
                               .max_by { |id, count| count }[0]

    Customer.find(favorite_customer_id)
  end

  def total_revenue
    { "revenue" => successful_invoices.joins(:invoice_items)
                                      .sum("unit_price * quantity") }
  end

  def total_revenue_on(date)
    { "revenue" => successful_invoices.where(created_at: date)
                                      .joins(:invoice_items)
                                      .sum("unit_price * quantity") }
  end

  def successful_invoices
    invoices.joins(:transactions)
            .where(:transactions => { result: "success" })
  end
end
