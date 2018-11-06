require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'when testing associations...' do
    it { is_expected.to have_many(:user_stocks) }
    it { is_expected.to have_many(:stocks).through(:user_stocks) }
    it { is_expected.to have_many(:friendship) }
    it { is_expected.to have_many(:friends).through(:friendship) }
  end

  describe 'when testing validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe 'when testing instance methods...' do
    let!(:user) do
      User.create!(email: '123@email.com',
                   password: '123123',
                   first_name: 'Alex',
                   last_name: 'Souza')
    end
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

    context '.search' do
      it 'expect to fetch a user according to first name' do
        fetched_user = User.search('Alex')
        expect(fetched_user).to be_an_instance_of Array
      end
    end

    context '#is_already_friend?' do
      let(:user2) do
        User.create!(email: '1234@email.com',
                     password: '123123',
                     first_name: 'Xeloncios',
                     last_name: 'Souza')
      end
      it 'expect to return true if two users are already friends' do
        user.friends << user2
        expect(user.already_friend?(user2)).to be_truthy
      end
    end
  end
end
