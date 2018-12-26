class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.date :invoice_date, index: true
      t.date :exchange_date
      t.float :exchange_rate
      t.float :value_usd
      t.float :value_ron

      t.string :title
      t.integer :tax_year

      t.timestamps
    end

    Invoice.setup
  end
end
