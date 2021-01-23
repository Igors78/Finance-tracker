class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy

    flash[:notice] = 'Stopped following!'
    redirect_to friendships_path
  end

  def create
    friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:notice] = 'Following user'
    else
      flash[:alert] = 'Something went wrong!'
    end
    redirect_to friendships_path
  end

  def search
    if params[:friend].present?
      @friends = User.search_friend(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: 'friendships/friend_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find the user!"
          format.js { render partial: 'friendships/friend_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = 'Please enter a friend name or email to search'
        format.js { render partial: 'friendships/friend_result' }
      end
    end
  end
end
