class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :customer_id
      t.string :merchant_id
      t.string :status
      t.string :created_at
      t.string :updated_at

      t.timestamps null: false
    end
  end
end
