class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friends
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
