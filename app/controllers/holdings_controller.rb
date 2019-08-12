require 'pry'

class HoldingsController < ApplicationController

    def new
        @holding = Holding.new(stock_id: params[:stock_id])
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
                if !params[:holding][:balance].empty?
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
                else
                    flash[:alert] = "Please input a valide number"
                    redirect_to stocks_path
                end
            end
        else
            redirect_to login_path
        end
    end

    def index
        if logged_in?
            @stock = Stock.find_by(id: params[:stock_id])
            @holdings = @stock.holdings.select { |f| f.account_id == current_account.id }
            #binding.pry
        else
            redirect_to login_path
        end
    end

    private

    def holding_params
        params.require(:holding).permit(:account_id, :stock_id, :balance)
    end

end
