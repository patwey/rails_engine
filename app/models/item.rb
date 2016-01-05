class Item < ActiveRecord::Base
  belongs_to :merchant

  before_save :set_unit_price

  default_scope -> { order('id DESC') }
  
  def self.random
    self.order("RANDOM()").first
  end

  private

  def set_unit_price
    self.unit_price = unit_price / 100.00
  end
end
