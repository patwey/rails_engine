class Customer < ActiveRecord::Base
  default_scope -> { order('id DESC') }

  def self.random
    self.order("RANDOM()").first
  end
end
