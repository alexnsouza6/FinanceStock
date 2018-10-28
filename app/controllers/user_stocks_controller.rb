# frozen_string_literal: true

# This controller handles associations between Users and Stocks
class UserStocksController < ApplicationController
  def create
    stock = Stock.find_by_ticker(params[:stock])
    if stock.blank?
      stock = Stock.quote_request(params[:stock])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:success] = "#{stock.name} has been successfully added!"
    redirect_to my_portfolio_path
  end
end
