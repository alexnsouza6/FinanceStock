class Stock < ApplicationRecord
  validates :ticker, presence: true
  validates :name, presence: true
  validates :last_price, presence: true
end
