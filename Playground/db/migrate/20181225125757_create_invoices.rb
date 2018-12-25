class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.date :invoice_date
      t.date :exchange_date
      t.float :exchange_rate
      t.float :value_usd
      t.float :value_ron

      t.timestamps
    end
  end
end
