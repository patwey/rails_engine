class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices

  default_scope -> { order('id DESC') }

  def self.random
    self.order("RANDOM()").first
  end

  def self.by_most_revenue(n)
    self.all
        .sort_by { |m| m.total_revenue["revenue"].to_f }
        .reverse
        .first(n)
  end

  def total_revenue
    { "revenue" => successful_transactions.reduce(0) { |sum, i| sum += i.total_revenue }
                                          .round(2)
                                          .to_s }
  end

  def total_revenue_on(date)
    { "revenue" => successful_transactions.where(created_at: date)
                                          .reduce(0) { |sum, i| sum += i.total_revenue }
                                          .round(2)
                                          .to_s }
  end


  def successful_transactions
    invoices.joins(:transactions)
            .where(:transactions => { result: "success" })
  end
end
