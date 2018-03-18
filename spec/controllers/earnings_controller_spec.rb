require 'rails_helper'

RSpec.describe EarningsController, type: :controller do
  let(:stock_exchange) { StockExchange.create!(name: 'ASX') }
  let(:stock) do
    stock_exchange.stocks.create!(
      company_name: 'Test Ltd',
      ticker_symbol: 'TST'
    )
  end

  describe '#new' do
    it 'returns http status 200' do
      get :new, params: { stock_id: stock.id }
    end
  end
end
