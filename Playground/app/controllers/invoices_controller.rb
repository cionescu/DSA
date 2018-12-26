class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.order(invoice_date: :asc).limit(50)
    @estimator = InvoiceEstimator.call
  end
end
