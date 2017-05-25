class UserController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice]="Signup successful. You can now login"
      redirect_to '/login'
    else
      flash[:error] = "Failed top signup"
      render :action => 'new'
    end
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
