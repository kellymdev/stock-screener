require 'rails_helper'

RSpec.describe Year, type: :model do
  describe 'validations' do
    let(:year) { Year.new(year_number: year_number) }

    context 'with a valid year number' do
      let(:year_number) { 2018 }

      it 'is valid' do
        expect(year).to be_valid
      end
    end

    context 'with an invalid year number' do
      context 'when the year number is too short' do
        let(:year_number) { 201 }

        it 'is invalid' do
          expect(year).not_to be_valid
          expect(year.errors.full_messages).to include('Year number must be between 1000 and 9999')
        end
      end

      context 'when the year number is too long' do
        let(:year_number) { 12345 }

        it 'is invalid' do
          expect(year).not_to be_valid
          expect(year.errors.full_messages).to include('Year number must be between 1000 and 9999')
        end
      end
    end
  end
end
