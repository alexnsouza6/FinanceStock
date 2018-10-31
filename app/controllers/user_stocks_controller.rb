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

  def destroy
    stock = Stock.find(params[:id])
    @user_stock = UserStock.where(user_id: current_user.id,
                                  stock_id: stock.id).first
    @user_stock.delete
    flash[:danger] = "#{stock.name} has been successfully deleted!"
    redirect_to my_portfolio_path
  end
end
