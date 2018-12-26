class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.limit(50)
  end
end
