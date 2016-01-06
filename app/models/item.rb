class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many   :invoice_items

  before_save :set_unit_price

  default_scope -> { order('id DESC') }

  def self.random
    self.order("RANDOM()").first
  end

  def self.most_items(n, item_ids_by_quantity)
    item_ids_by_quantity.sort_by { |id, quantity| quantity }
                        .reverse.first(n)
                        .map { |id, _| Item.find(id) }
  end

  def self.most_revenue(n, item_ids_by_revenue)
    item_ids_by_revenue.sort_by { |id, revenue| revenue }
                       .reverse.first(n)
                       .map { |id, _| Item.find(id) }
  end

  private

  def set_unit_price
    self.unit_price = unit_price / 100.00
  end
end
