class InvoicesController < ApplicationController
  def index
    start_date = params[:start_date]
    end_date = params[:end_date]

    if start_date.blank? || end_date.blank?
      render json: {error: "La fecha inicial y la fecha final son requeridas"}, status: :bad_request
      return
    end

    cache_key = "invoices_#{start_date}_#{end_date}"

    invoices = Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      Rails.logger.info "Cache miss: Fetching invoices from DB"
      Invoice.where(invoice_date: start_date..end_date)
    end
    
    render json: invoices, status: :ok
  end
end
