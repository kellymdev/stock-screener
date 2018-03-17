require 'rails_helper'

RSpec.describe SharePricesHelper, type: :helper do
  describe '#dollar_value' do
    it 'returns the value padded to two decimal places' do
      expect(dollar_value(1.2)).to eq '1.20'
    end
  end
end
