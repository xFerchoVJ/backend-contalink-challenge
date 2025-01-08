class SalesMailer < ApplicationMailer
  default from: 'fernandovj.dev@gmail.com'

  def top_sales_email
    top_sales = Invoice
      .group("DATE(invoice_date)")
      .select("DATE(invoice_date) as invoice_date, SUM(total) as total_sales")
      .order("total_sales DESC")
      .limit(10)
    
    mail(to: 'fernandovj.dev@gmail.com', subject: 'Top 10 Días con Más Ventas') do |format|
      format.html { render locals: { top_sales: top_sales } }
    end
  end
end
