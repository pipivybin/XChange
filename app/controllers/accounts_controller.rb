class AccountsController < ApplicationController
    def new
        @account = Account.new
    end
    
    def create
        @account = Account.new(account_params)
        if @account.valid?
            @account.save
            session[:acc_id] = @account.id
            redirect_to account_path(@account)
        else
            flash[:error] = "Please fill in all the information"
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

    def edit
    end

    def update
    end

    private

    def account_params
        params.require(:account).permit(:name, :password, :balance, :broker_acc)
    end
end
