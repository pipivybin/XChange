class StocksController < ApplicationController
    
    def index
        @stocks = Stock.all
    end

    def new
        if logged_in? && current_account.broker_acc
            @stock = Stock.new
            render 'new'
        else
            flash[:error] = "Sorry, you don't have access to it."
            redirect_to account_path(current_account)
        end
        
    end
    
    def create
        @stock = Stock.create(stock_params)
        redirect_to stock_path(@stock)
    end

    def show
        @stock = Stock.find_by(id: params[:id])
    end

    def edit
        if logged_in? && current_account.broker_acc
            @stock = Stock.find_by(id: params[:id])
        else
            flash[:error] = "Sorry, you don't have access to it."
            redirect_to stocks_path
        end
    end

    def update
        @stock = Stock.find_by(id: params[:id])
        @stock.update(stock_params)
        redirect_to stock_path(@stock)
    end

    private

    def stock_params
        params.require(:stock).permit(:name, :price)
    end
end
