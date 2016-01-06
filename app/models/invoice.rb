class Invoice < ActiveRecord::Base
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  belongs_to :customer
  belongs_to :merchant


  default_scope -> { order('id DESC') }

  def self.random
    self.order("RANDOM()").first
  end

  def total_revenue
    self.invoice_items.reduce(0) { |sum, ii| sum += ii.revenue; sum }
  end
end
