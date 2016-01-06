class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

  default_scope -> { order('id DESC') }

  def self.random
    self.order("RANDOM()").first
  end

  def self.favorite_merchant(id)
    # TODO: Fix this!
    self.find(id)
        .transactions
        .where(result: "success")
        .group_by { |t| t.merchant }
        .first
        .first
  end
end
