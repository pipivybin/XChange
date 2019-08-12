class HoldingsController < ApplicationController

    def new
    end

    def create
        #raise params.inspect
        if logged_in? && params[:holding][:stock_id]
            @holding = Holding.create(holding_params)
            @stock = Stock.find_by(id: params[:holding][:stock_id])
            @holding.account = current_account
            @holding.stock = @stock 
            @holding.balance = params[:holding][:balance].to_i
            @holding.price = @stock.price
            @holding.save
            flash[:alert] = "You just bought #{@stock.name} stock"
            redirect_to stocks_path
        else
            redirect_to login_path
        end
    end

    private

    def holding_params
        params.require(:holding).permit(:account_id, :stock_id, :balance)
    end

end
