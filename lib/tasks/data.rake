require 'CSV'

namespace :data do
  desc "Import SalesEngine CSVs into the database."
  task :import => :environment do
    import_customers
    import_merchants
    import_items
    import_invoices
    import_invoice_items
    import_transactions
  end
end

def import_customers
  customers_file = "#{Rails.root}/lib/assets/customers.csv"
  customers_csv = CSV.read(customers_file, headers: true, header_converters: :symbol).map { |r| r.to_h }
  customers_csv.each do |data|
    c = Customer.create!(data)
    puts_created(c)
  end
end

def import_merchants
  merchants_file = "#{Rails.root}/lib/assets/merchants.csv"
  merchants_csv = CSV.read(merchants_file, headers: true, header_converters: :symbol).map { |r| r.to_h }
  merchants_csv.each do |data|
    m = Merchant.create!(data)
    puts_created(m)
  end
end

def import_items
  items_file = "#{Rails.root}/lib/assets/items.csv"
  items_csv = CSV.read(items_file, headers: true, header_converters: :symbol).map { |r| r.to_h }
  items_csv.each do |data|
    i = Item.create!(name: data[:name],
                     description: data[:description],
                     unit_price:  data[:unit_price].to_i,
                     merchant_id: data[:merchant_id].to_i,
                     created_at:  data[:created_at],
                     updated_at:  data[:updated_at])
    puts_created(i)
  end
end

def import_invoices
  invoices_file = "#{Rails.root}/lib/assets/invoices.csv"
  invoices_csv = CSV.read(invoices_file, headers: true, header_converters: :symbol).map { |r| r.to_h }
  invoices_csv.each do |data|
    i = Invoice.create!(customer_id: data[:customer_id].to_i,
                        merchant_id: data[:merchant_id].to_i,
                        status:      data[:status],
                        created_at:  data[:created_at],
                        updated_at:  data[:updated_at])
    puts_created(i)
  end
end

def import_invoice_items
  invoice_items_file = "#{Rails.root}/lib/assets/invoice_items.csv"
  invoice_items_csv = CSV.read(invoice_items_file, headers: true, header_converters: :symbol).map { |r| r.to_h }
  invoice_items_csv.each do |data|
    ii = InvoiceItem.create!(item_id:    data[:item_id].to_i,
                             invoice_id: data[:invoice_id].to_i,
                             quantity:   data[:quantity].to_i,
                             unit_price: data[:unit_price].to_i,
                             created_at: data[:created_at],
                             updated_at: data[:updated_at])
    puts_created(ii)
  end
end

def import_transactions
  transactions_file = "#{Rails.root}/lib/assets/transactions.csv"
  transactions_csv = CSV.read(transactions_file, headers: true, header_converters: :symbol).map { |r| r.to_h }
  transactions_csv.each do |data|
    t = Transaction.create!(invoice_id:                  data[:invoice_id].to_i,
                            credit_card_number:          data[:credit_card_number],
                            result:                      data[:result],
                            created_at:                  data[:created_at],
                            updated_at:                  data[:updated_at])
    puts_created(t)
  end
end

def puts_created(obj)
  puts "Created #{obj.class.to_s} #{obj.id}"
end
