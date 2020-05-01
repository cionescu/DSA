class InvoicesController < ApplicationController
  def index
    @invoices = case params[:year]
    when nil
      invoice_scope
    else
      invoice_scope.where(tax_year: params[:year])
    end.limit(50)
    @estimator = InvoiceEstimator.call
  end

  def new
    @invoice = Invoice.new
  end

  def create
    if params[:invoice]
      @invoice = Invoice.create params.require(:invoice).to_unsafe_h
      BnrFetcher.new.perform(@invoice.id)
    else
      Invoice.setup
    end
    redirect_to root_path
  end

  def edit
    @invoice = Invoice.find params.require(:id)
  end

  def update
    @invoice = Invoice.find(params.require(:id))
    @invoice.update! params.require(:invoice).permit!
    BnrFetcher.new.perform(@invoice.id)
    redirect_to root_path
  end

  private

  def invoice_scope
    Invoice.order(invoice_date: :asc)
  end
end
