require 'rails_helper'

RSpec.describe Stock, type: :model do
  let(:stock_exchange) { StockExchange.create!(name: 'ASX') }
  let(:stock) do
    stock_exchange.stocks.create!(
      company_name: 'Test Ltd',
      ticker_symbol: 'TST'
    )
  end

  describe 'validations' do
    let(:name) { 'Test Stock Ltd' }
    let(:ticker) { 'TSL' }
    let(:stock) do
      stock_exchange.stocks.new(
        company_name: name,
        ticker_symbol: ticker
      )
    end

    context 'with valid details' do
      it 'is valid' do
        expect(stock).to be_valid
      end
    end

    context 'invalid name' do
      context 'when the name is missing' do
        let(:name) { '' }

        it 'is invalid' do
          expect(stock).not_to be_valid
        end
      end

      context 'when the name is too short' do
        let(:name) { 'Test' }

        it 'is invalid' do
          expect(stock).not_to be_valid
        end
      end
    end

    context 'invalid ticker symbol' do
      context 'when the ticker symbol is missing' do
        let(:ticker) { '' }

        it 'is invalid' do
          expect(stock).not_to be_valid
        end
      end

      context 'when the ticker symbol is too short' do
        let(:ticker) { 'T' }

        it 'is invalid' do
          expect(stock).not_to be_valid
        end
      end

      context 'when the ticker symbol already exists for the stock exchange' do
        let!(:existing_stock) do
          stock_exchange.stocks.create!(
            company_name: name,
            ticker_symbol: ticker
          )
        end

        it 'is invalid' do
          expect(stock).not_to be_valid
          expect(stock.errors.full_messages).to include('Ticker symbol should be unique for each stock exchange')
        end
      end
    end
  end

  describe '#can_calculate_price_earnings_ratio?' do
    let!(:year_1) { Year.create!(year_number: 2017) }
    let!(:year_2) { Year.create!(year_number: 2016) }
    let!(:share_price) do
      stock.share_prices.create!(
        year: year_1,
        high_value: 2.05,
        low_value: 1.23
      )
    end
    let!(:earning) do
      stock.earnings.create!(
        year: year_1,
        value: 0.05
      )
    end

    context 'when share price and earnings data exists for a year' do
      it 'is true' do
        expect(stock.can_calculate_price_earnings_ratio?(2017)).to eq true
      end
    end

    context 'when only the share price exists for a year' do
      before do
        share_price.update!(year: year_2)
      end

      it 'is false' do
        expect(stock.can_calculate_price_earnings_ratio?(2016)).to eq false
      end
    end

    context 'when only the earning exists for a year' do
      before do
        earning.update!(year: year_2)
      end

      it 'is false' do
        expect(stock.can_calculate_price_earnings_ratio?(2016)).to eq false
      end
    end
  end
end
