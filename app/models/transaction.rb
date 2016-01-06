class Transaction < ActiveRecord::Base
  belongs_to :invoice
  has_one :merchant, through: :invoice

  default_scope -> { order('id DESC') }
end
