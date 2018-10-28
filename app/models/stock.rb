#
class Stock < ApplicationRecord
  validates :ticker, presence: true
  validates :name, presence: true
  validates :last_price, presence: true

  def self.quote_request(stock_name)
    stock = StockQuote::Stock.quote(stock_name)
    new(ticker: stock.symbol, name: stock.company_name, last_price: stock.open)
  rescue StandardError
    nil
  end
end
