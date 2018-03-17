require 'rails_helper'

RSpec.describe DividendsController, type: :controller do
  render_views

  let(:stock_exchange) { StockExchange.create!(name: 'ASX') }
  let(:stock) do
    stock_exchange.stocks.create!(
      company_name: 'Test Ltd',
      ticker_symbol: 'TST'
    )
  end
  let(:year) { Year.create!(year_number: 2017) }
  let!(:dividend) do
    stock.dividends.create!(
      year: year,
      value: 0.05
    )
  end

  describe '#new' do
    it 'returns http status 200' do
      get :new, params: { stock_id: stock.id }

      expect(response.status).to eq 200
    end
  end

  describe '#create' do
    let(:params) do
      {
        stock_id: stock.id,
        dividend: {
          year_id: year.id,
          value: value
        }
      }
    end

    context 'with valid params' do
      let(:value) { 0.05 }

      it 'creates a dividend' do
        expect { post :create, params: params }.to change { Dividend.count }.by 1
      end
    end

    context 'with invalid params' do
      let(:value) {}

      it 'does not create a dividend' do
        expect { post :create, params: params }.to change { Dividend.count }.by 0
      end
    end
  end

  describe '#edit' do
    it 'returns http status 200' do
      get :edit, params: { id: dividend.id }

      expect(response.status).to eq 200
    end
  end

  describe '#update' do
    let(:params) do
      {
        id: dividend.id,
        dividend: {
          year_id: year.id,
          value: value
        }
      }
    end

    context 'with valid params' do
      let(:value) { 0.08 }

      it 'updates the dividend' do
        put :update, params: params

        expect(dividend.reload.value).to eq value
      end
    end

    context 'with invalid params' do
      let(:value) { 'test' }

      it 'does not update the dividend' do
        put :update, params: params

        expect(dividend.reload.value).to eq 0.05
      end
    end
  end
end
