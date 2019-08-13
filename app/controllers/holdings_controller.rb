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
                    current_account.update(balance: total)
                    @holding.price = @stock.price
                    @holding.save
                    @holding.account
                    if cost > 0
                        flash[:alert] = "You just bought #{@stock.name} stock"
                    else
                        flash[:alert] = "You just sold #{@stock.name} stock"
                    end
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
        else
            redirect_to login_path
        end
    end

    def show
        if logged_in? 
            @stock = Stock.find_by(id: params[:stock_id])
            @holding = Holding.find_by(id: params[:id])
            if @holding.account == current_account
                render 'show'
            else
                flash[:alert] = "Sorry. You don't have access to it"
                redirect_to login_path
            end
        else
            redirect_to login_path
        end
    end

    def update
        @stock = Stock.find_by(id: params[:holding][:stock_id])
        @holding = Holding.find_by(id: params[:id])
        if !params[:unit].empty? && params[:unit].to_i > 0 
            if params[:unit].to_i > @holding.balance
                flash[:alert] = "Sorry. You don't have enough balance"
                redirect_to stock_holding_path(@stock, @holding)
            else
                @holding.balance = @holding.balance - params[:unit].to_i
                @holding.save
                new_balance = params[:unit].to_i * @stock.price + current_account.balance
                current_account.update(balance: new_balance)
                redirect_to account_path(current_account)
            end
        else
            flash[:alert] = "Please enter a valid number"
            redirect_to stock_holding_path(@stock, @holding)
        end
    end

    private

    def holding_params
        params.require(:holding).permit(:account_id, :stock_id, :balance)
    end

end
