class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :invoice, index: true, foreign_key: true
      t.integer :credit_card_number
      t.datetime :credit_card_expiration_date
      t.string :result
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
