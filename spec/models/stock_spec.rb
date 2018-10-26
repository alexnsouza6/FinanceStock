require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe 'when testing validations...' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:ticker) }
    it { is_expected.to validate_presence_of(:last_price) }
  end
end
