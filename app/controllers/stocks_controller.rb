# frozen_string_literal: true

# This controller is denoted by Stock's actions
class StocksController < ApplicationController
  def search
    if params[:stock].blank?
      flash.now[:danger] = 'You have entered a blank string!'
    else
      @stock = Stock.quote_request(params[:stock])
      flash.now[:danger] = 'You have entered an invalid string!' unless @stock
    end
    respond_to do |format|
      format.js { render partial: 'users/stock_results' }
    end
  end
end
