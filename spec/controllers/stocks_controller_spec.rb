require 'rails_helper'

RSpec.describe StocksController, type: :controller do
  render_views

  let(:stock_exchange) { StockExchange.create!(name: 'ASX') }

  describe '#new' do
    it 'returns http status 200' do
      get :new, params: { stock_exchange_id: stock_exchange.id }

      expect(response.status).to eq 200
    end
  end
end
