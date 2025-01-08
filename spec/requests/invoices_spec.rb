require 'rails_helper'

RSpec.describe "Invoices API", type: :request do
  describe "GET /invoices" do
    let(:start_date) { "2025-01-01" }
    let(:end_date) { "2025-01-07" }

    it "returns invoinces within the date range" do
      get '/invoices', params: {start_date: start_date, end_date: end_date}

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)

      body.each do |invoice|
        invoice_date = Date.parse(invoice["invoice_date"])
        expect(invoice_date).to be_between(Date.parse(start_date), Date.parse(end_date))
      end
    end

    it "returns an empty array if no invoices are found" do
      get '/invoices', params: {start_date: '2025-01-08', end_date: '2025-01-14'}

      expect(response).to have_http_status(:ok)
      body = JSON.parse(request.body)
      expect(body).to be_empty
    end

    it "requires both start_date and end_date parameters" do
      get '/invoices', params: {start_date: start_date}
      
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)["error"]).to eq('La fecha inicial y la fecha final son requeridas')
    end
    
  end
end
