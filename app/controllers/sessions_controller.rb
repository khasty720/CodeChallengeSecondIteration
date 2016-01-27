class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      #Login
      puts "Login Valid"
      sign_in(user)
      redirect_to root_path, notice: 'Sign In Successful'
    else
      #Authentication Failed
      redirect_to login_path, alert: 'Invalid Username/Password'
    end
  end

  def destroy
    sign_out
    redirect_to root_path, notice: 'Sign Out Successful'
  end
end
