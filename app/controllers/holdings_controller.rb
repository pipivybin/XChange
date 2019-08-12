require 'pry'

class HoldingsController < ApplicationController

    def new
    end

    def create
        #raise params.inspect
        if logged_in? && params[:holding][:stock_id]
            @stock = Stock.find_by(id: params[:holding][:stock_id])
            cost = params[:holding][:balance].to_i * @stock.price
            if current_account.balance < cost
                flash[:alert] = "Sorry. You don't have enough balance"
                redirect_to stocks_path
            else
                total = current_account.balance - cost
                @holding = Holding.create(holding_params)
                @holding.account = current_account
                @holding.stock = @stock 
                @holding.balance = params[:holding][:balance].to_i
                current_account.update(balance: total)
                @holding.price = @stock.price
                @holding.save
                @holding.account
                flash[:alert] = "You just bought #{@stock.name} stock"
                redirect_to stocks_path
            end
        else
            redirect_to login_path
        end
    end

    private

    def holding_params
        params.require(:holding).permit(:account_id, :stock_id, :balance)
    end

end
