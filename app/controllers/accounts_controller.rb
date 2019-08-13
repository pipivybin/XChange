class AccountsController < ApplicationController
    
    def index
        redirect_to login_path
    end

    def new
        if logged_in?
            redirect_to account_path(current_account)
        else
        @account = Account.new
        end
    end
    
    def create
        @account = Account.new(account_params)
        if @account.valid?
            @account.save
            session[:acc_id] = @account.id
            redirect_to account_path(@account)
        else
            render 'new'
        end
    end

    def show
        if logged_in?
            @account = current_account
        else
            redirect_to login_path
        end
    end

    def update
        current_account.balance = params[:account][:balance]
        current_account.broker_acc = params[:account][:broker_acc]
        redirect_to account_path(@account)
    end

    private

    def account_params
        params.require(:account).permit(:name, :password, :password_confirmation, :balance, :broker_acc)
    end
end
