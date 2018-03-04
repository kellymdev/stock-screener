require 'rails_helper'

RSpec.describe Earning, type: :model do
  describe 'validations' do
    let(:stock_exchange) { StockExchange.create!(name: 'ASX') }
    let(:stock) do
      stock_exchange.stocks.create!(
        company_name: 'Test Ltd',
        ticker_symbol: 'TST'
      )
    end
    let(:year) { Year.create!(year_number: 2018) }
    let(:value) { 0.50 }
    let(:earning) { stock.earnings.new(year: year, value: value) }

    context 'with valid details' do
      context 'with a value' do
        it 'is valid' do
          expect(earning).to be_valid
        end
      end
    end

    context 'with invalid details' do
      context 'when the stock already has an earning record for that year' do
        let!(:existing_earning) { stock.earnings.create!(year: year, value: value) }

        it 'is invalid' do
          expect(earning).not_to be_valid
          expect(earning.errors.full_messages).to include('Stock already has an earning record for that year')
        end
      end

      context 'without a value' do
        let(:value) {}

        it 'is invalid' do
          expect(earning).not_to be_valid
        end
      end
    end
  end
end
