class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  def stock_already_added?(ticker_symbol)
    stock = Stock.find_by_ticker(ticker_symbol)
    return false unless stock

    user_stocks.where(stock_id: stock.id).exists?
  end

  def under_stock_limit?
    return true if stocks.count < 5

    false
  end

  def can_add_stock?(ticker_symbol)
    return true if !stock_already_added?(ticker_symbol) && under_stock_limit?

    false
  end
end
