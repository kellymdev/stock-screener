require 'rails_helper'

RSpec.describe ShareholdersEquity, type: :model do
  describe 'validations' do
    let(:stock_exchange) { StockExchange.create!(name: 'ASX') }
    let(:stock) do
      stock_exchange.stocks.create!(
        company_name: 'Test Ltd',
        ticker_symbol: 'TST'
      )
    end
    let(:year) { Year.create!(year_number: 2018) }
    let(:value) { 100_000_000 }
    let(:equity) { stock.shareholders_equities.new(year: year, value: value) }

    context 'with valid details' do
      context 'with a value' do
        it 'is valid' do
          expect(equity).to be_valid
        end
      end
    end

    context 'with invalid details' do
      shared_examples 'an invalid shareholders equity' do
        it 'is invalid' do
          expect(equity).not_to be_valid
        end
      end

      context 'when the stock already has a shareholders equity record for that year' do
        let!(:existing_earning) { stock.shareholders_equities.create!(year: year, value: value) }

        it 'is invalid' do
          expect(equity).not_to be_valid
          expect(equity.errors.full_messages).to include('Stock already has a shareholders equity record for that year')
        end
      end

      context 'without a value' do
        let(:value) {}

        it_behaves_like 'an invalid shareholders equity'
      end

      context 'when the value is not numeric' do
        let(:value) { 'test' }

        it_behaves_like 'an invalid shareholders equity'
      end
    end
  end
end
