class ChangeTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :credit_card_expiration_date, :datetime
    change_column :transactions, :credit_card_number, :string
  end
end
