class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.order(invoice_date: :asc).limit(50)
    @estimator = InvoiceEstimator.call
  end

  def create
    Invoice.setup
    redirect_to root_path
  end
end
