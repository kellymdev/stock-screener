require 'rails_helper'

RSpec.describe GenerateStockReport, type: :controller do
  describe '#call' do
    let!(:stock_exchange) { StockExchange.create!(name: 'ASX') }
    let!(:stock) do
      stock_exchange.stocks.create!(
        company_name: 'Test Stock',
        ticker_symbol: 'TST'
      )
    end
    let!(:year_1) { Year.create!(year_number: 2017) }
    let!(:year_2) { Year.create!(year_number: 2016) }
    let!(:year_3) { Year.create!(year_number: 2015) }
    let!(:price) { stock.share_prices.create!(year: year_1, high_value: 2.99, low_value: 1.45) }
    let!(:earning) { stock.earnings.create!(year: year_1, value: 0.95) }
    let!(:dividend_1) { stock.dividends.create!(year: year_1, value: 0.05) }
    let!(:dividend_2) { stock.dividends.create!(year: year_1, value: 0.12) }
    let(:time) { Time.parse("2018-07-07 16:23:32 +1200") }
    let(:current_price) { '4.00' }
    let(:report_params) do
      {
        current_price: current_price
      }
    end
    let(:service) { described_class.new(stock, report_params) }

    before do
      allow(Time).to receive(:now).and_return(time)
    end

    context 'for a single year' do
      context 'with valid data' do
        let(:expected_data) do
          {
            generated_at: time.to_s,
            report_data: {
              2017 => {
                high_price: '2.99'.to_d,
                low_price: '1.45'.to_d,
                high_pe_ratio: '3.1'.to_d,
                low_pe_ratio: '1.5'.to_d,
                earnings: '0.95'.to_d,
                total_dividends: '0.17'.to_d,
                retained_earnings: '0.78'.to_d
              }
            },
            report_summary: {
              total_dividends: '0.17'.to_d,
              total_retained_earnings: '0.78'.to_d,
              dividend_percentage: '17.89'.to_d,
              retained_earnings_percentage: '82.11'.to_d,
              initial_rate_of_return: {
                current_price: '4.00'.to_d,
                estimated_earnings: '0.95'.to_d
              },
              growth: {
                per_share_growth_rate: '0.00'.to_d
              }
            }
          }
        end

        it 'returns data values for the year' do
          expect(service.call).to eq expected_data
        end
      end
    end

    context 'for multiple years' do
      let!(:price_2) { stock.share_prices.create!(year: year, high_value: 3.47, low_value: 2.81) }
      let!(:earning_2) { stock.earnings.create!(year: year, value: 0.75) }
      let!(:dividend_3) { stock.dividends.create!(year: year, value: 0.08) }

      context 'for consecutive years' do
        let(:year) { year_2 }
        let(:expected_data) do
          {
            generated_at: time.to_s,
            report_data: {
              2016 => {
                high_price: '3.47'.to_d,
                low_price: '2.81'.to_d,
                high_pe_ratio: '4.6'.to_d,
                low_pe_ratio: '3.7'.to_d,
                earnings: '0.75'.to_d,
                total_dividends: '0.08'.to_d,
                retained_earnings: '0.67'.to_d
              },
              2017 => {
                high_price: '2.99'.to_d,
                low_price: '1.45'.to_d,
                high_pe_ratio: '3.1'.to_d,
                low_pe_ratio: '1.5'.to_d,
                earnings: '0.95'.to_d,
                total_dividends: '0.17'.to_d,
                retained_earnings: '0.78'.to_d
              }
            },
            report_summary: {
              total_dividends: '0.25'.to_d,
              total_retained_earnings: '1.45'.to_d,
              dividend_percentage: '14.71'.to_d,
              retained_earnings_percentage: '85.29'.to_d,
              initial_rate_of_return: {
                current_price: '4.00'.to_d,
                estimated_earnings: '1.21'.to_d
              },
              growth: {
                per_share_growth_rate: '27.00'.to_d
              }
            }
          }
        end

        it 'returns data values for both years' do
          expect(service.call).to eq expected_data
        end
      end

      context 'for non-consecutive years' do
        let(:year) { year_3 }
        let(:expected_data) do
          {
            2017 => {
              high_price: '2.99'.to_d,
              low_price: '1.45'.to_d,
              high_pe_ratio: '3.1'.to_d,
              low_pe_ratio: '1.5'.to_d,
              earnings: '0.95'.to_d,
              total_dividends: '0.17'.to_d,
              retained_earnings: '0.78'.to_d
            }
          }
        end

        it 'only returns data for the most recent consecutive years' do
          expect(service.call[:report_data]).to eq expected_data
        end
      end
    end

    context 'with invalid data' do
      context 'when there is not enough data for the year' do
        let!(:earning) { stock.earnings.create!(year: year_2, value: 0.75) }

        it 'does not include the year in the report' do
          data = service.call

          expect(data[:report_data][2016]).to eq nil
        end
      end
    end
  end
end
