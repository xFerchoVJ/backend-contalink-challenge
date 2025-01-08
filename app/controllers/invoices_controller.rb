class InvoicesController < ApplicationController
  def index
    start_date = params[:start_date]
    end_date = params[:end_date]

    if start_date.blank? || end_date.blank?
      render json: {error: "La fecha inicial y la fecha final son requeridas"}, status: :bad_request
      return
    end

    invoices = Invoice.where(invoice_date: start_date..end_date)
    render json: invoices, status: :ok
  end
end
