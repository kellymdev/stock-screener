# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShareholdersEquitiesController, :type => :controller do
  let!(:stock_exchange) { StockExchange.create!(name: 'ASX') }
  let!(:stock) do
    stock_exchange.stocks.create!(
      company_name: 'Existing Stock',
      ticker_symbol: 'EXT'
    )
  end
  let(:year_2017) { Year.create!(year_number: 2017) }
  let(:year_2016) { Year.create!(year_number: 2016) }
  let!(:shareholders_equity) do
    stock.shareholders_equities.create!(
      year: year_2016,
      value: 2_000
    )
  end

  describe '#new' do
    it 'returns http status 200' do
      get :new, params: { stock_id: stock.to_param }

      expect(response.status).to eq 200
    end
  end

  describe '#create' do
    let(:params) do
      {
        stock_id: stock.to_param,
        shareholders_equity: {
          year_id: year_2017.to_param,
          value: value
        }
      }
    end

    context 'with valid params' do
      let(:value) { 1_000 }

      it 'creates a shareholders equity record' do
        expect { post :create, params: params }.to change(ShareholdersEquity, :count).by 1
      end
    end

    context 'with invalid params' do
      let(:value) { 'test' }

      it 'does not create a shareholders equity record' do
        expect { post :create, params: params }.not_to change(ShareholdersEquity, :count)
      end
    end
  end

  describe '#edit' do
    it 'returns http status 200' do
      get :edit, params: { id: shareholders_equity.to_param }

      expect(response.status).to eq 200
    end
  end

  describe '#update' do
    let(:params) do
      {
        id: shareholders_equity.to_param,
        shareholders_equity: {
          year: year_2016.to_param,
          value: value
        }
      }
    end

    context 'with valid params' do
      let(:value) { 1_500 }

      it 'updates the shareholders equity' do
        post :update, params: params

        expect(shareholders_equity.reload.value).to eq value
      end
    end

    context 'with invalid params' do
      let(:value) { 'test' }

      it 'does not update the shareholders equity' do
        post :update, params: params

        expect(shareholders_equity.reload.value).to eq 2_000
      end
    end
  end

  describe '#destroy' do
    it 'deletes the shareholders equity record' do
      expect { delete :destroy, params: { id: shareholders_equity.to_param } }.to change(ShareholdersEquity, :count).by(-1)
    end
  end
end
