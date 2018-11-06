# frozen_string_literal: true
#
class FriendshipsController < ApplicationController
  def destroy
    @friendship = current_user.friendship.find_by(friend_id: params[:id])
    @friendship.destroy
    flash[:notice] = 'Friendship destroyed successfully'
    redirect_to my_friends_path
  end
end
