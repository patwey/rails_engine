class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

  default_scope -> { order('id DESC') }

  def favorite_merchant
    favorite_merchant_id = self.invoices.where(status: "shipped")
                               .group(:merchant_id)
                               .count
                               .max_by { |id, count| count }[0]

    Merchant.find(favorite_merchant_id)
  end
end
