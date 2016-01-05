class Customer < ActiveRecord::Base
  def self.random
    offset = rand(self.count)
    self.offset(offset).first
  end
end
