class InvoiceItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :invoice

  before_save :set_unit_price

  def self.random
    self.order("RANDOM()").first
  end

  private

  def set_unit_price
    self.unit_price = unit_price / 100.00
  end
end
