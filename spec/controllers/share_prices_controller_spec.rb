require 'rails_helper'

RSpec.describe SharePricesController, type: :controller do
  render_views

  let!(:year_2017) { Year.create!(year_number: 2017) }
  let!(:year_2016) { Year.create!(year_number: 2016) }
  let!(:stock_exchange) { StockExchange.create!(name: 'ASX') }
  let!(:stock) do
    stock_exchange.stocks.create!(
      company_name: 'Test Ltd',
      ticker_symbol: 'TST'
    )
  end
  let!(:share_price) do
    stock.share_prices.create!(
      year: year_2016,
      high_value: 1.89,
      low_value: 1.28
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
          year_id: year_2017.id,
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

  describe '#edit' do
    it 'returns http status 200' do
      get :edit, params: { id: share_price.id }

      expect(response.status).to eq 200
    end
  end

  describe '#update' do
    let(:high_value) { 2.45 }
    let(:low_value) { 1.20 }
    let(:params) do
      {
        id: share_price.id,
        share_price: {
          year_id: year_2016.id,
          high_value: high_value,
          low_value: low_value
        }
      }
    end

    context 'with valid params' do
      it 'updates the share price' do
        put :update, params: params

        expect(share_price.reload.high_value).to eq high_value
        expect(share_price.reload.low_value).to eq low_value
      end
    end

    context 'with invalid params' do
      it 'does not update the share price' do
        expect(share_price.reload.high_value).to eq 1.89
        expect(share_price.reload.low_value).to eq 1.28
      end
    end
  end

  describe '#destroy' do
    it 'deletes the share price' do
      expect { delete :destroy, params: { id: share_price.id } }.to change { SharePrice.count }.by -1
    end
  end
end
