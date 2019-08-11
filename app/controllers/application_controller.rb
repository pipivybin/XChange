class ApplicationController < ActionController::Base
    helper_method :current_account, :logged_in?

    def current_account
        Account.find_by(id: session[:acc_id]) || nil
    end

    def logged_in?
        !!current_account
    end

end
