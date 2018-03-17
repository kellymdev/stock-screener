require 'rails_helper'

RSpec.describe SharePricesController, type: :controller do
  render_views

  let!(:year) { Year.create!(year_number: '2017') }
  let!(:stock_exchange) { StockExchange.create!(name: 'ASX') }
  let!(:stock) do
    stock_exchange.stocks.create!(
      company_name: 'Test Ltd',
      ticker_symbol: 'TST'
    )
  end

  describe '#new' do
    it 'returns http status 200' do
      get :new, params: { stock_id: stock.id }

      expect(response.status).to eq 200
    end
  end

  describe '#create' do
    let(:high_value) { '1.50' }
    let(:params) do
      {
        stock_id: stock.id,
        share_price: {
          year_id: year.id,
          high_value: high_value,
          low_value: '1.09'
        }
      }
    end

    context 'with valid params' do
      it 'creates a share price' do
        expect { post :create, params: params }.to change { SharePrice.count }.by 1
      end
    end

    context 'with invalid params' do
      let(:high_value) {}

      it 'does not create a share price' do
        expect { post :create, params: params }.to change { SharePrice.count }.by 0
      end
    end
  end
end
