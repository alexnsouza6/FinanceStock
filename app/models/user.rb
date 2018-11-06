class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendship
  has_many :friends, through: :friendship

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true

  # Instance Methods

  def already_friend?(user_id)
    friendship.where(friend_id: user_id).exists?
  end

  def except_current_user(users)
    users.reject { |user| user.id == id }
  end

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

  def self.search(param)
    users = (query_first_name(param) +
             query_last_name(param) +
             query_email(param)).uniq
    return nil unless users

    users
  end

  def self.query_first_name(param)
    matches('first_name', param)
  end

  def self.query_last_name(param)
    matches('last_name', param)
  end

  def self.query_email(param)
    matches('email', param)
  end

  def self.matches(field, param)
    where("#{field} like ?", "%#{param}%")
  end
end
