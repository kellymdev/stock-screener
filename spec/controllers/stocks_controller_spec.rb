require 'rails_helper'

RSpec.describe StocksController, type: :controller do
  render_views

  let!(:stock_exchange) { StockExchange.create!(name: 'ASX') }
  let!(:stock) do
    stock_exchange.stocks.create!(
      company_name: 'Existing Stock',
      ticker_symbol: 'EXT'
    )
  end

  describe '#new' do
    it 'returns http status 200' do
      get :new, params: { stock_exchange_id: stock_exchange.id }

      expect(response.status).to eq 200
    end
  end

  describe '#create' do
    let(:company_name) { 'Test Ltd' }
    let(:ticker_symbol) { 'TST' }
    let(:stock_params) do
      {
        stock_exchange_id: stock_exchange.id,
        stock: {
          company_name: company_name,
          ticker_symbol: ticker_symbol
        }
      }
    end
    context 'with valid params' do
      it 'creates a new stock' do
        expect { post :create, params: stock_params }.to change { Stock.count }.by 1
      end
    end

    context 'with invalid params' do
      let(:company_name) { 'Test' }

      it 'does not create a new stock' do
        expect { post :create, params: stock_params }.to change { Stock.count }.by 0
      end
    end
  end

  describe '#show' do
    it 'returns http status 200' do
      get :show, params: { stock_exchange_id: stock_exchange.id, id: stock.id }

      expect(response.status).to eq 200
    end
  end
end
