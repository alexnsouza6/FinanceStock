require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'when testing associations...' do
    it { is_expected.to have_many(:user_stocks) }
    it { is_expected.to have_many(:stocks).through(:user_stocks) }
  end

  describe 'when testing validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe 'when testing instance methods...' do
    let(:user) { User.create(email: '123@email.com', password: '123123') }
    let(:stock) do
      Stock.create(ticker: 'GOOG', name: 'Alphabet Inc.', last_price: 13_000)
    end

    context '#stock_already_added?' do
      it 'expects to return true if user already added stock' do
        user.stocks << stock
        expect(user.stock_already_added?('GOOG')).to be_truthy
      end

      it 'expects to return false if user hasnt added stock' do
        expect(user.stock_already_added?('GOOG')).to be_falsy
      end
    end

    context '#under_stock_limit?' do
      it 'expects to return true if user has less than 5 stocks' do
        user.stocks << stock
        expect(user.under_stock_limit?).to be_truthy
      end

      it 'expects to return false if user has more than 5 stocks' do
        allow(user.stocks).to receive(:count).and_return(5)
        expect(user.under_stock_limit?).to be_falsy
      end
    end

    context '#can_add_stock?' do
      it 'returns true if !stock_already_added? and under_stock_limit?' do
        allow(user).to receive(:stock_already_added?).and_return(false)
        allow(user).to receive(:under_stock_limit?).and_return(true)
        expect(user.can_add_stock?('GOOG')).to be_truthy
      end

      it 'returns false if !stock_already_added? and under_stock_limit?' do
        allow(user).to receive(:stock_already_added?).and_return(true)
        allow(user).to receive(:under_stock_limit?).and_return(true)
        expect(user.can_add_stock?('GOOG')).to be_falsy
      end
    end
  end
end
