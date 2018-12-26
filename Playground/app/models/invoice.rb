# == Schema Information
#
# Table name: invoices
#
#  id            :bigint(8)        not null, primary key
#  exchange_date :date
#  exchange_rate :float
#  invoice_date  :date
#  tax_year      :integer
#  title         :string
#  value_ron     :float
#  value_usd     :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_invoices_on_invoice_date  (invoice_date)
#

class Invoice < ApplicationRecord
  before_save :set_tax_year, :set_ron_value, :set_title, :truncate_ron

  def self.setup
    InvoiceFetcherJob.new.perform
  end

  private

  def set_title
    return unless invoice_date
    self.title = "Invoice #{invoice_date.strftime('%B')} #{invoice_date.year}"
  end

  def truncate_ron
    return unless value_ron
    self.value_ron = value_ron.round(2)
  end

  def set_ron_value
    return unless value_usd && exchange_rate
    self.value_ron = value_usd * exchange_rate
  end

  def set_tax_year
    return if tax_year || !invoice_date
    self.tax_year = if invoice_date.month == 12
      invoice_date.year + 1
    else
      invoice_date.year
    end
  end
end
