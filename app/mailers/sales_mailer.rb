class SalesMailer < ApplicationMailer
  default from: 'fernandovj.dev@gmail.com'

  def top_sales_email(top_sales)
    @top_sales = top_sales
    mail(to: ENV["MAIL_TO"], subject: 'Top 10 Días con Más Ventas') do |format|
      format.html { render 'top_sales_email' }
    end
  end
end
