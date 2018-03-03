require 'rails_helper'

RSpec.describe StockExchange, type: :model do
  describe 'validations' do
    let(:stock_exchange) { StockExchange.new(name: name) }

    context 'with a valid name' do
      let(:name) { 'ASX' }

      it 'is valid' do
        expect(stock_exchange).to be_valid
      end
    end

    context 'when the name is missing' do
      let(:name) { '' }

      it 'is not valid' do
        expect(stock_exchange).not_to be_valid
      end
    end

    context 'when the name is too short' do
      let(:name) { 'AS' }

      it 'is not valid' do
        expect(stock_exchange).not_to be_valid
      end
    end
  end
end
