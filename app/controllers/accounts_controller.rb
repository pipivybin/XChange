class AccountsController < ApplicationController
    def new
    end
    
    def create
    end

    def show
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
