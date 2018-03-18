require 'rails_helper'

RSpec.describe EarningsController, type: :controller do
  let(:stock_exchange) { StockExchange.create!(name: 'ASX') }
  let(:stock) do
    stock_exchange.stocks.create!(
      company_name: 'Test Ltd',
      ticker_symbol: 'TST'
    )
  end
  let(:year) { Year.create!(year_number: 2017) }

  describe '#new' do
    it 'returns http status 200' do
      get :new, params: { stock_id: stock.id }
    end
  end

  describe '#create' do
    let(:params) do
      {
        stock_id: stock.id,
        earning: {
          year_id: year.id,
          value: value
        }
      }
    end

    context 'with valid params' do
      let(:value) { 0.45 }

      it 'creates an earning' do
        expect { post :create, params: params }.to change { Earning.count }.by 1
      end
    end

    context 'with invalid params' do
      let(:value) { 'test' }

      it 'does not create an earning' do
        expect { post :create, params: params }.to change { Earning.count }.by 0
      end
    end
  end
end
