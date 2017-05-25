class SessionController < ApplicationController

  def new
    @user = User.new
  end

  def create
    email = params[:user][:email]
    password = params[:user][:password]

    @user = User.find_by_email(email)

    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      current_user
      flash[:notice] = "Logged in Successfully"
      redirect_to root_url
    else
      flash[:error] = "Incorrect Credentials"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
