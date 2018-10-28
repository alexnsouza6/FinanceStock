require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe 'when testing validations...' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:ticker) }
    it { is_expected.to validate_presence_of(:last_price) }
  end

  describe 'when testing associations...' do
    it { is_expected.to have_many(:user_stocks) }
    it { is_expected.to have_many(:users).through(:user_stocks) }
  end

  describe 'when testing class methods...' do
    context '.quote_request' do
      context 'when requested symbol is valid' do
        let(:stock) { Stock.quote_request('GOOG') }
        it 'expects to return a new stock object' do
          expect(stock).to be_an_instance_of Stock
        end

        it 'expects to return a stock object with a name' do
          expect(stock.name).not_to be nil
        end
      end

      context 'when requested symbol is not valid' do
        let(:stock) { Stock.quote_request('Some_string') }
        it 'expects to return a new stock object' do
          expect(stock).to be nil
        end
      end
    end
  end
end
