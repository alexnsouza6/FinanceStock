require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'when testing associations...' do
    it { is_expected.to belong_to(:friend) }
    it { is_expected.to belong_to(:user) }
  end
end
