class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant

  default_scope -> { order('id DESC') }

  def self.random
    self.order("RANDOM()").first
  end
end
