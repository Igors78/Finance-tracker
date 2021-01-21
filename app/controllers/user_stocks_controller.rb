class UserStocksController < ApplicationController
  def create
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} added to your portfolio"
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    UserStock.destroy_by(user_id: current_user.id, stock_id: stock.id)

    flash[:notice] = "#{stock.ticker} was removed from track!"
    redirect_to my_portfolio_path
  end
end
