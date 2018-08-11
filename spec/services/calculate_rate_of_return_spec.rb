require 'rails_helper'

RSpec.describe CalculateRateOfReturn, type: :service do
  describe '#call' do
    let(:number_of_years) { 5 }
    subject(:service) { described_class.new(present_value, future_value, number_of_years) }

    context 'when the present value is lower than the future value' do
      let(:present_value) { '4.00'.to_d }
      let(:future_value) { '8.00'.to_d }

      it 'returns a positive rate' do
        expect(service.call).to eq '15.00'.to_d
      end
    end

    context 'when the present value is higher than the future value' do
      let(:present_value) { '8.00'.to_d }
      let(:future_value) { '4.00'.to_d }

      it 'returns a negative rate' do
        expect(service.call).to eq '-13.00'.to_d
      end
    end

    context 'when the present value and future value are the same' do
      let(:present_value) { '4.00'.to_d }
      let(:future_value) { '4.00'.to_d }

      it 'returns a rate of zero' do
        expect(service.call).to eq '0.00'.to_d
      end
    end
  end
end
