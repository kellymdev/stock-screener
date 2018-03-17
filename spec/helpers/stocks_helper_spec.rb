require 'rails_helper'

RSpec.describe StocksHelper, type: :helper do
  let(:stock_exchange) { StockExchange.create!(name: 'ASX') }
  let(:stock) do
    stock_exchange.stocks.create!(
      company_name: 'Test Ltd',
      ticker_symbol: 'TST'
    )
  end

  describe '#full_ticker_symbol' do
    it 'returns the stock exchange name followed by the stock ticker symbol' do
      expect(full_ticker_symbol(stock)).to eq 'ASX:TST'
    end
  end
end
