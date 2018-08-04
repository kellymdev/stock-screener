require 'rails_helper'

RSpec.describe SharePricesHelper, type: :helper do
  describe '#dollar_value' do
    context 'when there is a price' do
      it 'returns the value padded to two decimal places' do
        expect(dollar_value(1.2)).to eq '1.20'
      end
    end

    context 'when the price is nil' do
      it 'returns 0.00' do
        expect(dollar_value(nil)).to eq '0.00'
      end
    end
  end
end
