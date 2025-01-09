class SendTopSalesEmailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    top_sales = Invoice
    .group("DATE(invoice_date)")
    .select("DATE(invoice_date) as invoice_date, SUM(total) as total_sales")
    .order("total_sales DESC")
    .limit(10)
    .map { |sale| {invoice_date: sale.invoice_date, total_sales: sale.total_sales} }

    SalesMailer.top_sales_email(top_sales).deliver_now
  end
end
