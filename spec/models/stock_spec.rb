require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe 'validations' do
    let(:name) { 'Test Stock Ltd' }
    let(:ticker) { 'TSL' }
    let(:stock_exchange) { StockExchange.create!(name: 'ASX') }
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
end
