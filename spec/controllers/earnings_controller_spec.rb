require 'rails_helper'

RSpec.describe EarningsController, type: :controller do
  let(:stock_exchange) { StockExchange.create!(name: 'ASX') }
  let(:stock) do
    stock_exchange.stocks.create!(
      company_name: 'Test Ltd',
      ticker_symbol: 'TST'
    )
  end
  let(:year_2017) { Year.create!(year_number: 2017) }
  let(:year_2016) { Year.create!(year_number: 2016) }
  let!(:earning) do
    stock.earnings.create!(
      year: year_2016,
      value: 0.45
    )
  end

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
          year_id: year_2017.id,
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

  describe '#edit' do
    it 'returns http status 200' do
      get :edit, params: { id: earning.id }

      expect(response.status).to eq 200
    end
  end

  describe '#update' do
    let(:params) do
      {
        id: earning.id,
        earning: {
          year_id: year_2016.id,
          value: value
        }
      }
    end

    context 'with valid params' do
      let(:value) { 0.67 }

      it 'updates the earning' do
        put :update, params: params

        expect(earning.reload.value).to eq value
      end
    end

    context 'with invalid params' do
      let(:value) { 'test' }

      it 'does not update the earning' do
        put :update, params: params

        expect(earning.reload.value).to eq 0.45
      end
    end
  end
end
