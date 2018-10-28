require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'when testing associations...' do
    it { is_expected.to have_many(:user_stocks) }
    it { is_expected.to have_many(:stocks).through(:user_stocks) }
  end
end
