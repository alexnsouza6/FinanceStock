# frozen_string_literal: true

# Controller that handles user UI
class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    @user_stocks = @user.stocks
  end

  def my_friends
    @friendship = current_user.friends
  end

  def search
    @users = User.search(params[:search_params])
    render json: @users, status: 200
  end
end
