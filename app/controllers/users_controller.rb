# frozen_string_literal: true

class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    @tracked_stocks = current_user.stocks
  end

  def show_user
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
    render 'show_user'
  end
end
