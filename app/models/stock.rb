#
class Stock < ApplicationRecord

  # Validations
  validates :ticker, presence: true
  validates :name, presence: true
  validates :last_price, presence: true

  # Associations
  has_many :user_stocks
  has_many :users, through: :user_stocks

  # Class Methods
  def self.quote_request(stock_name)
    stock = StockQuote::Stock.quote(stock_name)
    new(ticker: stock.symbol, name: stock.company_name, last_price: stock.open)
  rescue StandardError
    nil
  end
end
