class Transaction < ActiveRecord::Base
  belongs_to :invoice

  default_scope -> { order('id DESC') }
end
