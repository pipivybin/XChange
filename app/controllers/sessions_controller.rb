class SessionsController < ApplicationController
  
  def new
    if !logged_in?
      @account = Account.new
    else
      flash[:alert] = "You already logged in."
      redirect_to account_path(current_account)
    end
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

  def fbcreate
    
    @account = Account.from_omniauth(auth)
    session[:acc_id] = @account.id
    redirect_to account_path(@account)
  end

  def destroy
    session.delete :acc_id
    redirect_to login_path
  end

  private
 
  def auth
    request.env['omniauth.auth']
  end

end
