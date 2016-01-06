class Transaction < ActiveRecord::Base
  belongs_to :invoice

  default_scope -> { order('id DESC') }

  def self.random
    self.order("RANDOM()").first
  end
end
