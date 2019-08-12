class HoldingsController < ApplicationController

    def create
        @holding = Holding.create(holding_params)
        @stock = Stock.find_by(id: params[:id])
        @holding.account = current_account
        @holding.stock = @stock 
        #raise params[:holding][:balance].inspect
        @holding.balance += params[:holding][:balance].to_i
        flash[:alert] = "You just bought #{@stock.name}"
        redirect_to stocks_path
    end

    private

    def holding_params
        params.require(:holding).permit(:account_id, :stock_id, :balance)
    end

end
