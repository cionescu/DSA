class InvoiceEstimator
  attr_reader :invoices, :years

  TARGET = 480_000.freeze

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
      invoice_count = relevant_invoices.map(&:invoice_date).map(&:month).uniq.count
      total_ron = relevant_invoices.inject(0){ |sum, invoice| sum += invoice.value_ron.to_f }.round(2)
      remaining = invoice_count >= 12 ? "N/A" : (TARGET - total_ron).round(2)
      latest_exchange_rate = Invoice.order(invoice_date: :desc).first.exchange_rate
      remaining_ron = remaining_per_month_ron(remaining, invoice_count)
      remaining_usd = remaining_ron.to_i.zero? ? "N/A" : (remaining_ron / latest_exchange_rate.to_f).to_i

      OpenStruct.new({
        Year: year,
        TARGET_USD: ActiveSupport::NumberHelper.number_to_currency(TARGET / latest_exchange_rate),
        TARGET_USD_PM: ActiveSupport::NumberHelper.number_to_currency((TARGET / latest_exchange_rate) / 12),
        USD: ActiveSupport::NumberHelper.number_to_currency(relevant_invoices.inject(0){ |sum, invoice| sum += invoice.value_usd.to_f }.to_i),
        RON: ActiveSupport::NumberHelper.number_to_delimited(total_ron),
        MONTHS: invoice_count,
        "Remaining RON" => ActiveSupport::NumberHelper.number_to_delimited(remaining),
        "Remaining per month" => ActiveSupport::NumberHelper.number_to_delimited(remaining_per_month_ron(remaining, invoice_count)),
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
    invoices.select{ |invoice| invoice.tax_year == year }.reject{ |invoice| invoice.tax_year == Time.current.year && invoice.invoice_date.month == Time.current.month }
  end
end
