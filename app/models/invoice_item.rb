class InvoiceItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :invoice

  before_save :set_unit_price

  default_scope -> { order('id DESC') }

  def self.random
    self.order("RANDOM()").first
  end

  def revenue
    (self.unit_price * self.quantity).to_f
  end

  def self.all_items_by_revenue
    all.group_by { |ii| ii.item_id }
        .map { |id, a| [id, a.reduce(0) { |total, ii| total += ii.revenue; total }] }
        .to_h
  end

  def self.all_items_by_quantity
    all.group_by { |ii| ii.item_id }
        .map { |id, a| [id, a.reduce(0) { |total, ii| total += ii.quantity; total }] }
        .to_h
  end

  private

  def set_unit_price
    self.unit_price = unit_price / 100.00
  end
end
