require 'rails_helper'

RSpec.describe CalculatePriceEarningsRatio, type: :service do
  describe '#call' do
    let(:year) { Year.create!(year_number: 2017) }
    let(:stock_exchange) { StockExchange.create!(name: 'ASX') }
    let(:stock) do
      stock_exchange.stocks.create!(
        company_name: 'Test Ltd',
        ticker_symbol: 'TST'
      )
    end

    context 'when both a price and an earning exist for the year' do
      let!(:price) do
        stock.share_prices.create!(
          year: year,
          high_value: 1.05,
          low_value: 0.75
        )
      end
      let!(:earning) do
        stock.earnings.create!(
          year: year,
          value: 0.40
        )
      end
      let(:expected_result) do
        {
          high_pe_ratio: 2.625,
          low_pe_ratio: 1.875
        }
      end

      it 'returns the price earning ratios' do
        expect(described_class.new(year, stock).call).to eq expected_result
      end
    end

    context 'when only a price exists for the year' do
      let!(:price) do
        stock.share_prices.create!(
          year: year,
          high_value: 1.05,
          low_value: 0.75
        )
      end

      it 'returns nil' do
        expect(described_class.new(year, stock).call).to eq nil
      end
    end

    context 'when only an earning exists for the year' do
      let!(:earning) do
        stock.earnings.create!(
          year: year,
          value: 0.40
        )
      end

      it 'returns nil' do
        expect(described_class.new(year, stock).call).to eq nil
      end
    end
  end
end
