require 'rails_helper'

RSpec.describe StockExchangesController, type: :controller do
  render_views

  let!(:stock_exchange) { StockExchange.create!(name: 'ASX') }
  let!(:stock) do
    stock_exchange.stocks.create!(
      company_name: 'Test Ltd',
      ticker_symbol: 'TST'
    )
  end

  describe '#index' do
    it 'returns http status 200' do
      get :index

      expect(response.status).to eq 200
    end
  end

  describe '#show' do
    it 'returns http status 200' do
      get :show, params: { id: stock_exchange.id }

      expect(response.status).to eq 200
    end
  end
end
