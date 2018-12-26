# == Schema Information
#
# Table name: invoices
#
#  id            :bigint(8)        not null, primary key
#  exchange_date :date
#  exchange_rate :float
#  invoice_date  :date
#  title         :string
#  value_ron     :float
#  value_usd     :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Invoice < ApplicationRecord
end
