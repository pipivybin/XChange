class SessionsController < ApplicationController
  
  def new
    @account = Account.new
  end

  def create
    @account = Account.find_by(name: params[:account][:name])
     if @account && @account.authenticate(params[:account][:password])
      session[:acc_id] = @account.id 
      redirect_to account_path(@account)
     else
      redirect_to login_path 
     end
  end

  def destroy
    session.delete :user_id
  end
end
