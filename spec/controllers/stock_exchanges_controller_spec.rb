require 'rails_helper'

RSpec.describe StockExchangesController, type: :controller do
  describe '#index' do
    it 'returns http status 200' do
      get :index

      expect(response.status).to eq 200
    end
  end
end
