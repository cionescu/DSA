class InvoiceEstimator
  attr_reader :invoices, :years

  TARGET = 455_000.freeze

  def initialize
    @invoices = Invoice.limit(50)
    @years = @invoices.map(&:tax_year).uniq.sort
  end

  def self.call
    new.call
  end

  def call
    years.map do |year|
      relevant_invoices = find_invoices(year)
      total_ron = relevant_invoices.inject(0){ |sum, invoice| sum += invoice.value_ron }.round(2)
      remaining = relevant_invoices.count >= 12 ? "N/A" : (TARGET - total_ron).round(2)
      latest_exchange_rate = Invoice.order(invoice_date: :desc).first.exchange_rate
      remaining_ron = remaining_per_month_ron(remaining, relevant_invoices.count)
      remaining_usd = remaining_ron.to_i.zero? ? "N/A" : (remaining_ron / latest_exchange_rate.to_f).to_i

      OpenStruct.new({
        Year: year,
        USD: ActiveSupport::NumberHelper.number_to_currency(relevant_invoices.inject(0){ |sum, invoice| sum += invoice.value_usd }.to_i),
        RON: ActiveSupport::NumberHelper.number_to_delimited(total_ron),
        MONTHS: relevant_invoices.count,
        "Remaining RON" => ActiveSupport::NumberHelper.number_to_delimited(remaining),
        "Remaining per month" => ActiveSupport::NumberHelper.number_to_delimited(remaining_per_month_ron(remaining, relevant_invoices.count)),
        "Remaining USD" => ActiveSupport::NumberHelper.number_to_currency(remaining_usd)
      })
    end
  end

  private

  def remaining_per_month_ron(remaining, invoice_count)
    return "N/A" if invoice_count >= 12
    value = remaining / (12 - invoice_count)
    value.round(2)
  end

  def find_invoices(year)
    invoices.select{ |invoice| invoice.tax_year == year }
  end
end
