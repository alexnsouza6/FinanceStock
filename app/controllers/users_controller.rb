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
    if params[:search_param].blank?
      flash.now[:danger] = 'You have entered an empty search string'
    else
      @users = User.search(params[:search_param])
      @users = current_user.except_current_user(@users)
      flash.now[:danger] = 'No users match this search criteria' if @users.blank?
    end
    respond_to do |format|
      format.js { render partial: 'friends/result' }
    end
  end

  def show
    @user = User.find(params[:id])
    @user_stocks = @user.stocks
  end

  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendship.build(friend_id: @friend.id)
    if current_user.save
      flash[:success] = 'Friend successfully added'
    else
      flash[:danger] = 'Something wrong happened'
    end
    redirect_to my_friends_path
  end
end
