require 'CSV'

namespace :data do
  desc "Import SalesEngine CSVs into the database."
  task :import => :environment do
    # import customers
    # customers_file = "#{Rails.root}/lib/assets/customers.csv"
    # customers_csv = CSV.read(customers_file, headers: true, header_converters: :symbol).map { |r| r.to_h }
    # customers_csv.each(&populate(Customer))

    # import invoice_items
    # invoice_items_file = "#{Rails.root}/lib/assets/invoice_items.csv"
    # invoice_items_csv = CSV.read(invoice_items_file, headers: true, header_converters: :symbol).map { |r| r.to_h }
    # invoice_items_csv.each(&populate(InvoiceItem))

    # import invoices
    invoices_file = "#{Rails.root}/lib/assets/invoices.csv"
    invoices_csv = CSV.read(invoices_file, headers: true, header_converters: :symbol).map { |r| r.to_h }
    invoices_csv.each(&populate(Invoice))

    # import items
    
    # import merchants
    # import transactions
  end
end

def populate(klass)
  proc do |data|
    k = klass.create!(data)
    puts_created(k)
  end
end

def puts_created(obj)
  puts "Created #{obj.class.to_s} #{obj.id}"
end
