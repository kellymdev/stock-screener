require 'rails_helper'

RSpec.describe DividendsController, type: :controller do
  render_views

  let(:stock_exchange) { StockExchange.create!(name: 'ASX') }
  let(:stock) do
    stock_exchange.stocks.create!(
      company_name: 'Test Ltd',
      ticker_symbol: 'TST'
    )
  end
  let(:year) { Year.create!(year_number: 2017) }

  describe '#new' do
    it 'returns http status 200' do
      get :new, params: { stock_id: stock.id }

      expect(response.status).to eq 200
    end
  end
end
