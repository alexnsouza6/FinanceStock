require 'rails_helper'

RSpec.describe UserStock, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:stock) }
end
