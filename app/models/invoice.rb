class Invoice < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :customer

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.random
    self.order("RANDOM()").first
  end

  def total_revenue
    self.invoice_items.reduce(0) { |sum, ii| sum += ii.revenue; sum }
  end
end
