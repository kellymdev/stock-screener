require 'rails_helper'

RSpec.describe Dividend, type: :model do
  describe 'validations' do
    let(:stock_exchange) { StockExchange.create!(name: 'ASX') }
    let(:stock) do
      stock_exchange.stocks.create!(
        company_name: 'Test Ltd',
        ticker_symbol: 'TST'
      )
    end
    let(:year) { Year.create!(year_number: 2018) }
    let(:dividend) { stock.dividends.new(year: year, value: value) }

    context 'with a value' do
      let(:value) { 0.25 }

      it 'is valid' do
        expect(dividend).to be_valid
      end
    end

    context 'without a value' do
      let(:value) {}

      it 'is invalid' do
        expect(dividend).not_to be_valid
      end
    end
  end
end
