class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items

  default_scope -> { order('id DESC') }

  def self.random
    self.order("RANDOM()").first
  end
end
