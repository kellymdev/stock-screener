require 'rails_helper'

RSpec.describe SharePrice, type: :model do
  describe 'validations' do
    let(:stock_exchange) { StockExchange.create!(name: 'ASX') }
    let(:stock) do
      stock_exchange.stocks.create!(
        company_name: 'Test Ltd',
        ticker_symbol: 'TST'
      )
    end
    let(:year) { Year.create!(year_number: 2018) }
    let(:high_value) { 1.00 }
    let(:low_value) { 0.50 }
    let(:share_price) do
      stock.share_prices.new(
        year: year,
        high_value: high_value,
        low_value: low_value
      )
    end

    context 'with valid details' do
      shared_examples 'a valid share price' do
        it 'is valid' do
          expect(share_price).to be_valid
        end
      end

      context 'when the high value is higher than the low value' do
        it_behaves_like 'a valid share price'
      end

      context 'when the high value is equal to the low value' do
        let(:high_value) { 2.00 }
        let(:low_value) { 2.00 }

        it_behaves_like 'a valid share price'
      end
    end

    context 'with invalid details' do
      shared_examples 'an invalid share price' do
        it 'is invalid' do
          expect(share_price).not_to be_valid
        end
      end

      context 'when the stock already has a price for that year' do
        let!(:existing_stock_price) do
          stock.share_prices.create!(
            year: year,
            high_value: 1.50,
            low_value: 0.98
          )
        end

        it_behaves_like 'an invalid share price'
      end

      context 'when the stock does not have a high value' do
        let(:high_value) {}

        it_behaves_like 'an invalid share price'
      end

      context 'when the high value is not a number' do
        let(:high_value) { 'test' }

        it_behaves_like 'an invalid share price'
      end

      context 'when the stock does not have a low value' do
        let(:low_value) {}

        it_behaves_like 'an invalid share price'
      end

      context 'when the low value is not a number' do
        let(:low_value) { 'test' }

        it_behaves_like 'an invalid share price'
      end

      context 'when the high value is lower than the low value' do
        let(:high_value) { 2.00 }
        let(:low_value) { 2.01 }

        it_behaves_like 'an invalid share price'
      end
    end
  end
end
