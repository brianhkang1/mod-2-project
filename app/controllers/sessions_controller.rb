class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:user][:username])
    user = user.try(:authenticate, params[:user][:password])
    if !user
      return redirect_to(controller: 'sessions', action: 'new')
    else
      session[:user_id] = user.id
      @user = user
      redirect_to '/'
    end
  end

  def destroy
    session.delete :user_id
    redirect_to '/'
  end

end
