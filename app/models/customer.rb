class Customer < ActiveRecord::Base
  has_many :invoices
  
  default_scope -> { order('id DESC') }

  def self.random
    self.order("RANDOM()").first
  end
end
