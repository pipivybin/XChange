class SessionsController < ApplicationController
  def new
  end

  def create
  end

  def destroy
    session.delete :user_id
  end
end
