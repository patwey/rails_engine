class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions

  default_scope -> { order('id DESC') }

  def self.random
    self.order("RANDOM()").first
  end
end
