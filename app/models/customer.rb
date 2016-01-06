class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

  default_scope -> { order('id DESC') }

  def self.favorite_merchant(id)
    self.find(id)
        .transactions
        .where(result: "success")
        .group_by { |t| t.merchant }
        .sort_by { |m, t| t.count }
        .reverse
        .first
        .first
  end
end
