class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def search
    render json: params[:friend]
  end
end
