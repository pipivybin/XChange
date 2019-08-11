class StocksController < ApplicationController
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

    def stock_params
        params.require(:stock).permit(:name, :price)
    end
end
