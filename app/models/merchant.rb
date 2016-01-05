class Merchant < ActiveRecord::Base
  has_many :items
  
  default_scope -> { order('id DESC') }

  def self.random
    self.order("RANDOM()").first
  end
end
